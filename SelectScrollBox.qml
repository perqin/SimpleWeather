import QtQuick 2.3

Item {
    id: root;

    property int buttonTop;
    property int buttonHeight: 128;
    property bool selecting: false;
    property alias selectedIndex: list.currentIndex;
    property alias model: list.model;
    property bool haveName: false;

    Item {
        id: box;
        anchors.left: parent.left; anchors.right: parent.right;
        y: selecting ? 0 : buttonTop;
        height: selecting ? parent.height : buttonHeight;
        ListView {
            id: list;
            anchors.fill: parent;
            delegate: delegate;
            enabled: selecting;
            Component {
                id: delegate;
                Item {
                    width: root.width;
                    height: root.buttonHeight;
                    Item {
                        id: selectedIndicator;
                        anchors.left: parent.left; anchors.top: parent.top;
                        height: parent.height; width: height;
                        Rectangle {
                            color: "White"; width: 32; height: 32; radius: 16;
                            visible: index == selectedIndex;
                        }
                    }
                    Item {
                        anchors.right: parent.right; anchors.top: parent.top;
                        height: parent.height; anchors.left: selectedIndicator.right;
                        Text {
                            color: "White";
                            anchors.centerIn: parent;
                            text: haveName ? modelData.name : modelData;
                        }
                    }
                    MouseArea {
                        anchors.fill: parent;
                        onClicked: {
                            selecting = !selecting;
                        }
                    }
                }
            }
        }
        MouseArea {
            anchors.fill: parent; enabled: !selecting;
            onClicked: {
                selecting = !selecting;
                if (!selecting) {
                    list.contentY = selectedIndex * buttonHeight;
                }
            }
        }
    }
    Rectangle { color: "White"; anchors.top: box.top; anchors.left: box.left; anchors.right: box.right; height: 1; }
    Rectangle { color: "White"; anchors.bottom: box.bottom; anchors.left: box.left; anchors.right: box.right; height: 1; }
    Rectangle { color: "White"; anchors.left: box.left; anchors.top: box.top; anchors.bottom: box.bottom; height: 1; }
    Rectangle { color: "White"; anchors.right: box.right; anchors.top: box.top; anchors.bottom: box.bottom; height: 1; }
}
