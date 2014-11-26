import QtQuick 2.3
import QtQuick.XmlListModel 2.0

Rectangle {
    id: main
    width: 360
    height: 360
    color: "lightsteelblue"

    XmlListModel {
        id: postsXmlList

        source: "http://konachan.com/post.xml?tags=blood&limit=100"
        query: "/posts/post"

        XmlRole {
            name: "tags"
            query: "@tags/string()"
        }
    }

    ListView {
        id: view

        anchors.margins: 10
        anchors.fill: parent
        spacing: 10
        model: postsXmlList

        delegate: Rectangle {
            width: view.width
            height: 40
            radius: 10

            Text {
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
                wrapMode: Text.Wrap
                renderType: Text.NativeRendering
                text: model.tags
            }
        }
    }

/*    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    Text {
        anchors.centerIn: parent
        text: "Hello World"
    } */
}

