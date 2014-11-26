import QtQuick 2.3
import QtQuick.XmlListModel 2.0

Rectangle {
    id: main
    width: 360
    height: 360
    color: "lightsteelblue"

    XmlListModel {
        id: postsXmlList

        source: "http://konachan.com/post.xml"
        query: "/posts/post"

        XmlRole {
            name: "tags"
            query: "@tags/string()"
        }
    }

    GridView {

        id: postsView

        anchors.margins: 10
        anchors.fill: parent
        cellHeight: 100
        cellWidth: cellHeight

        model: postsXmlList
        clip: true

        highlight: Rectangle {
            color: "black"
        }

        delegate: Item {

            property var view: GridView.view
            property var isCurrent: GridView.isCurrentItem

            height: postsView.cellHeight -80
            width: postsView.cellWidth

            Rectangle {
                anchors.margins: 5
                anchors.fill: parent
                color: "lightgreen"

                Text {
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    renderType: Text.NativeRendering
                    text: model.tags
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                }
            }
        }
    }
}

