import QtQuick 2.10
import QtQuick.Layouts 1.0
import QtQuick.Shapes 1.10
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4

Item
{
    width: 200; height: 100

    function set_rssi(rssi) 
    {
        if(rssi > 0.8)
        {
            rssiHigh.visible = true;
        }
        else
        {
            rssiHigh.visible = false;
        }

        if(rssi > 0.3)
        {
            rssiMid.visible = true;
        }
        else
        {
            rssiMid.visible = false;
        }

        if(rssi > 0.1)
        {
            rssiLow.visible = true;
        }
        else
        {
            rssiLow.visible = false;
        }        
    }
    Item
    {
        id: topItem
    	width: 200; height: 100
        anchors.fill: parent

        Rectangle
        {
            color: "transparent"
            anchors.fill: parent
            Rectangle
            {
                id: rssiLow
                color: "white"
                width: topItem.width*0.2; height: topItem.height*0.3
                x: topItem.x + topItem.width*0.1; y: topItem.y + topItem.height - height
            }
            Rectangle
            {
                id: rssiMid
                color: "white"
                width: topItem.width*0.2; height:topItem.height*0.6
                x: topItem.x + topItem.width*0.4; y: topItem.y + topItem.height - height
            }
            Rectangle
            {
                id: rssiHigh
                color: "white"
                width: topItem.width*0.2; height:topItem.height*0.9
                x: topItem.x + topItem.width*0.7; y: topItem.y + topItem.height - height
            }
        }
    }
}
