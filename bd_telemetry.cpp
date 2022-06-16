#include <cstdint>
#include <future>
#include <mavsdk/mavsdk.h>
#include <mavsdk/plugins/telemetry/telemetry.h>
#include <iostream>
#include <thread>

#include <unistd.h>
#include <sys/time.h>
#include <sys/timerfd.h>
#include "bd_telemetry.hpp"


using namespace mavsdk;
using namespace std::this_thread;
using namespace std::chrono;


struct periodic_info {
    int timer_fd;
    unsigned long long wakeups_missed;
};

static int make_periodic(unsigned int period, struct periodic_info *info)
{
    int ret;
    unsigned int ns;
    unsigned int sec;
    int fd;
    struct itimerspec itval;

    /* Create the timer */
    fd = timerfd_create(CLOCK_MONOTONIC, 0);
    info->wakeups_missed = 0;
    info->timer_fd = fd;
    if (fd == -1)
        return fd;

    /* Make the timer periodic */
    sec = period / 1000000;
    ns = (period - (sec * 1000000)) * 1000;
    itval.it_interval.tv_sec = sec;
    itval.it_interval.tv_nsec = ns;
    itval.it_value.tv_sec = sec;
    itval.it_value.tv_nsec = ns;
    ret = timerfd_settime(fd, 0, &itval, NULL);
    return ret;
}

static void wait_period(struct periodic_info *info)
{
    unsigned long long missed;
    int ret;

    /* Wait for the next timer event. If we have missed any the
       number is written to "missed" */
    ret = read(info->timer_fd, &missed, sizeof(missed));
    if (ret == -1) {
        perror("read timer");
        return;
    }

    info->wakeups_missed += missed;
}



void usage(const std::string& bin_name)
{
    std::cerr << "Usage : " << bin_name << " <connection_url>\n"
              << "Connection URL format should be :\n"
              << " For TCP : tcp://[server_host][:server_port]\n"
              << " For UDP : udp://[bind_host][:bind_port]\n"
              << " For Serial : serial:///path/to/serial/dev[:baudrate]\n"
              << "For example, to connect to the simulator use URL: udp://:14540\n";
}

std::shared_ptr<System> get_system(Mavsdk& mavsdk)
{
    std::cout << "Waiting to discover system...\n";
    auto prom = std::promise<std::shared_ptr<System>>{};
    auto fut = prom.get_future();

    // We wait for new systems to be discovered, once we find one that has an
    // autopilot, we decide to use it.
    mavsdk.subscribe_on_new_system([&mavsdk, &prom]() {
        auto system = mavsdk.systems().back();

        if (system->has_autopilot()) {
            std::cout << "Discovered autopilot\n";

            // Unsubscribe again as we only want to find one system.
            mavsdk.subscribe_on_new_system(nullptr);
            prom.set_value(system);
        }
    });

    // We usually receive heartbeats at 1Hz, therefore we should find a
    // system after around 3 seconds max, surely.
    if (fut.wait_for(seconds(3)) == std::future_status::timeout) {
        std::cerr << "No autopilot found.\n";
        return {};
    }

    // Get discovered system now.
    return fut.get();
}

struct bdTelemetry::impl
{
    bool connected = false;
    std::string server;
    Mavsdk mavsdk;
    std::shared_ptr<System> system;
    std::shared_ptr<Telemetry> telemetry;
    //struct periodic_info perinfo;
};


bdTelemetry::bdTelemetry() : pimpl(std::make_unique<bdTelemetry::impl>())
{

}

bdTelemetry::~bdTelemetry()
{

}

bool bdTelemetry::connect(std::string server)
{
    pimpl->server = server;
    {
        ConnectionResult connection_result = pimpl->mavsdk.add_any_connection(pimpl->server);
        pimpl->system = nullptr;
        pimpl->telemetry = nullptr;

        if(connection_result != ConnectionResult::Success) 
        {
            std::cerr << "Connection failed: " << connection_result;
        }
        else
        {
            pimpl->connected = true;
            pimpl->system = get_system(pimpl->mavsdk);
        }

        if(!pimpl->system) 
        {
            std::cerr << "mavsdk get_system failed.";
            pimpl->connected = false;
        }
        else
        {
            pimpl->telemetry = std::make_shared<Telemetry>(pimpl->system);
        }
        
    }

    return pimpl->connected;         
}

bool bdTelemetry::isConnected()
{
    return pimpl->connected;
}

void bdTelemetry::getEuler(float &yaw, float &pitch, float &roll)
{    
    if(pimpl->connected == false)
    {
        return;
    }
    auto euler = pimpl->telemetry->attitude_euler();
    yaw = euler.yaw_deg;
    pitch = euler.pitch_deg;
    roll = euler.roll_deg;
}


void bdTelemetry::getOdometry(float &x_m, float &y_m, float &z_m)
{
    if(pimpl->connected == false)
    {
        return;
    }

    auto odom = pimpl->telemetry->odometry();
    std::cout << odom;
    x_m = odom.position_body.x_m;
    y_m = odom.position_body.y_m;
    z_m = odom.position_body.z_m;
}

void bdTelemetry::getNed(float &x_m, float &y_m, float &z_m, float &vx, float &vy, float &vz)
{
    if(pimpl->connected == false)
    {
        return;
    }   

    auto ned = pimpl->telemetry->position_velocity_ned();
    x_m = ned.position.east_m;
    y_m = ned.position.north_m;
    z_m = ned.position.down_m;
    vx = ned.velocity.east_m_s;
    vy = ned.velocity.north_m_s;
    vz = ned.velocity.down_m_s;
}

void bdTelemetry::getHealthBattery(float &voltage, float &percent, bool &can_arm, bool &pos_ok, bool &sens_ok)
{
    if(pimpl->connected == false)
    {
        return;
    }

    auto health = pimpl->telemetry->health();

    pos_ok = health.is_local_position_ok;
    sens_ok = true;
    sens_ok &= health.is_gyrometer_calibration_ok;
    sens_ok &= health.is_accelerometer_calibration_ok;
    can_arm = true;//health.is_armable;

    auto batt = pimpl->telemetry->battery();
    voltage = batt.voltage_v;
    percent = batt.remaining_percent;
}
