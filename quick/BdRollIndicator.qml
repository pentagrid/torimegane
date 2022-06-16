import QtQuick 2.10
import QtQuick.Layouts 1.0
import QtQuick.Shapes 1.10

Item
{
    id: topItem
	width: 200; height: 26


    Shape 
    {
        ShapePath 
        {
            strokeColor: "red"
            strokeStyle: ShapePath.DashLine
            dashPattern: [2,4,2,4,2,22,2,4,2,4,2,2]
            strokeWidth: 4

            startX: 0
            startY: topItem.height/2

            PathLine
            {
            	x: topItem.width
            	y: topItem.height/2
            }
        }
    }
}
