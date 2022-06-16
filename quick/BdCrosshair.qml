import QtQuick 2.10
import QtQuick.Layouts 1.0
import QtQuick.Shapes 1.10

Item
{
    id: topItem
	width: 50; height: 26

	Repeater 
	{
        id: centerCross
        model: 2
        Shape 
        {
            ShapePath 
            {
                strokeColor: model.index === 0 ? "red" : "blue"
                strokeStyle: ShapePath.DashLine
                dashPattern: [2,2]
                strokeWidth: 1

                startX: model.index == 0 ? 0 : topItem.width/2
                startY: model.index == 0 ? topItem.height/2  : 0

                PathLine
                {
                	x: model.index == 0 ? topItem.width : topItem.width/2
                	y: model.index == 0 ? topItem.height/2 : topItem.height
                }
            }
        }
    }
}
