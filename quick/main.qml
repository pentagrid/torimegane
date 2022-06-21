import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import QtWebEngine 1.8
import com.brincdrones 1.0

Window 
{
    property var mavServerAddress: "udp://:14540"
    property var rtcServerAddress: "https://vivo.local:8443/demos/mein_listen.html"

    
    width: 1280
    height: 720
    visible: true
    Rectangle
    {
        //anchors.fill: parent
        anchors.top: parent.top
        width: 1280
        height: 720
        color: "black"

        BdBackEnd
        {
            id: backend
        }

        GridLayout
        {
            columns: 1; rows: 2
            columnSpacing: 4; rowSpacing: 1
            anchors.fill: parent
            Item
            {
                Layout.fillHeight: true; Layout.fillWidth: true
                Layout.preferredHeight: 480-75

                WebEngineView 
                {
                    anchors.centerIn: parent
                    anchors.fill: parent
                    onCertificateError: error.ignoreCertificateError()
                    url: rtcServerAddress

                	onFeaturePermissionRequested: 
                	{
                		grantFeaturePermission(securityOrigin, feature, true);
                	}
                }

                BdCrosshair { anchors.centerIn: parent }
                
                BdRollIndicator
                { 
                    id: rollIndicator
                    transform: Rotation 
                    { 
                        id: rollTransform; 
                        origin.x: rollIndicator.width/2; origin.y: rollIndicator.height/2; 
                        angle: 0 
                    }
                    anchors.centerIn: parent 
                } 
            }

            BdStatusBar 
            { 
                id: statusBar
                Layout.fillHeight: true; Layout.fillWidth: true; 
                Layout.preferredHeight: 75
            }
        }

        Timer 
        {
            id: timer
            interval: 100; repeat: true
            running: true; triggeredOnStart: false
            onTriggered: 
            {
                if(backend.isConnected() == false)
                {
                    backend.connect(mavServerAddress)
                }
                var eulers = backend.getTelem()

                statusBar.textDisplayData.yaw = eulers["yaw"].toString().substr(0,7) + "°"
                statusBar.textDisplayData.pitch = eulers["pitch"].toString().substr(0,7) + "°"  
                statusBar.textDisplayData.roll = eulers["roll"].toString().substr(0,7) + "°"
                statusBar.textDisplayData.ekusu = eulers["x_body"].toString().substr(1,6) + " m"
                statusBar.textDisplayData.wai = eulers["y_body"].toString().substr(1,6) + " m"
                statusBar.textDisplayData.zetto = eulers["z_body"].toString().substr(1,6) + " m"
                statusBar.extDisplayData.vx = eulers["x_speed"].toString().substr(1,6) + " m/s"
                statusBar.extDisplayData.vy = eulers["y_speed"].toString().substr(1,6) + " m/s"
                statusBar.extDisplayData.vz = eulers["z_speed"].toString().substr(1,6) + " m/s"
                statusBar.extDisplayData.voltage = eulers["batt_voltage"].toString().substr(1,4) + " V"
                statusBar.extDisplayData.can_arm = eulers["can_arm"]
                statusBar.extDisplayData.imu_good = eulers["imu_ok"]
                rollTransform.angle = eulers["roll"]                
            }
        }
    }
}
