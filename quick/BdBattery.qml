import QtQuick 2.10
import QtQuick.Layouts 1.0
import QtQuick.Shapes 1.10
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4

Item
{
    property alias value: batteryStatus.value
    width: 200; height: 100
    Item
    {
        id: topItem
    	width: 200; height: 100
        anchors.fill: parent
        Shape 
        {
            ShapePath 
            {
                strokeColor: "white"
                fillColor: strokeColor
                strokeWidth: 8
                joinStyle: ShapePath.RoundJoin
                capStyle: ShapePath.RoundCap
                startX: 0
                startY: 0

                PathLine
                {
                    x: topItem.width*0.85
                    y: 0
                }
                PathLine
                {
                    x: topItem.width*0.85
                    y: topItem.height/2*0.8
                }

                PathLine
                {
                    x: topItem.width
                    y: topItem.height/2*0.8
                }
                PathLine
                {
                    x: topItem.width
                    y: topItem.height/2*1.2
                }
                PathLine
                {
                    x: topItem.width*0.85
                    y: topItem.height/2*1.2
                }            
                PathLine
                {
                    x: topItem.width*0.85
                    y: topItem.height
                }
                PathLine
                {
                    x: 0
                    y: topItem.height
                }
                PathLine
                {
                    x: 0
                    y: 0
                }            
            }
        }
        Rectangle
        {
            color: "transparent"
            width: topItem.width*0.8; height:topItem.height*0.7
            x: topItem.x; y: topItem.y
            Gauge
            {
                id: batteryStatus
                width: parent.width; height:parent.height/2
                anchors.centerIn: parent
                orientation: Qt.Horizontal
                minimumValue: 0
                maximumValue: 100
                value: 50
                tickmarkStepSize: 100
                minorTickmarkCount: 0
                style: GaugeStyle 
                {
                    valueBar: Rectangle 
                    {
                        implicitWidth: topItem.height*0.7
                        color: "black"
                    }
                    tickmark: null
                    minorTickmark: null
                    tickmarkLabel: null
                }
            }
        }
    }
}
