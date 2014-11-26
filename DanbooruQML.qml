import QtQuick 2.3
import QtQuick.XmlListModel 2.0
import QtQuick.Layouts 1.1

Rectangle {
    id: main
    width: 720
    height: 600
    color: "darkgrey"

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

        XmlRole {
            name: "file_url"
            query: "@file_url/string()"
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

        header: Rectangle {
            width: parent.width
            height: 20
            color: "lightblue"
            opacity: 0.8
            Text {
                anchors.centerIn: parent
                text: "Page 1"
            }
        }

        footer: Rectangle {
            width: parent.width
            height: 20
            color: "lightblue"
            opacity: 0.8
            Text {
                anchors.centerIn: parent
                text: "Page 1"
            }
        }

        highlight: Rectangle {
            color: "lightblue"
            radius: 5
            opacity: 0.4
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
                    onDoubleClicked: Qt.openUrlExternally(model.file_url)
                }
            }
        }
    }
}

