/*
 * bd_telemetry.h 
 * \file manages the MAVSDK telemetry calls for bd app
 * \author david.perek@brincdrones.com
 * \copyright Copyright 2022 Brinc Drones Inc All Rights Reserved
 */
#ifndef BDTELEMETRY_HPP
#define BDTELEMETRY_HPP

class bdTelemetry
{
	private:
		struct impl;
		std::unique_ptr<impl> pimpl;
	public:
		/* main constructor*/
		bdTelemetry();
		~bdTelemetry();

		bool isConnected();

		/*initiates a connection to the server*/
		bool connect(std::string server);

		/*currently just provide a simple blocking polling based way to get the euler angles of the attitude*/
		void getEuler(float &yaw, float &pitch, float &roll);

		/* get the odometry data*/
		void getOdometry(float &x_m, float &y_m, float &z_m);

		/* get the NED data */
		void getNed(float &x_m, float &y_m, float &z_m, float &vx, float &vy, float &vz);
		/* Gets the battery status and sensing health status */
		void getHealthBattery(float &voltage, float &percent, bool &can_arm, bool &pos_ok, bool &sens_ok);
};

#endif //BDTELEMETRY_HPP