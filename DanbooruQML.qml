import QtQuick 2.3
import QtQuick.XmlListModel 2.0
import QtQuick.Layouts 1.1

Rectangle {
    id: main
    width: 600
    height: 600
    color: "black"

    XmlListModel {
        id: postsXmlList

        source: "http://konachan.com/post.xml"
        query: "/posts/post"

        XmlRole {
            name: "tags"
            query: "@tags/string()"
        }

        XmlRole {
            name: "preview_url"
            query: "@preview_url/string()"
        }
    }

    GridView {

        id: postsView

        anchors.margins: 10
        anchors.fill: parent

        cellHeight: 300
        cellWidth: cellHeight

        model: postsXmlList
        clip: true

        highlight: Rectangle {
            color: "lightblue"
            radius: 5
            opacity: 0.2
        }

        delegate: Item {

            property var view: GridView.view
            property var isCurrent: GridView.isCurrentItem

            height: postsView.cellHeight
            width: postsView.cellWidth

            ColumnLayout {
                anchors.margins: 5
                anchors.fill: parent
                //color: "lightgreen"
                spacing: 5

                Image {
                    Layout.preferredWidth: parent.width
                    source: model.preview_url
                    fillMode: Image.PreserveAspectFit
                }

                Text {
                    anchors.margins: 5
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: parent.width
                    color: "white"
                    renderType: Text.NativeRendering
                    text: model.tags
                    wrapMode: Text.WordWrap
                    elide: Text.ElideRight
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: postsView.currentIndex = model.index
                }
            }
        }
    }
}

