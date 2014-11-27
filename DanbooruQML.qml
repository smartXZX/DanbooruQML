import QtQuick 2.3
import QtQuick.XmlListModel 2.0
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.2

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

        cellHeight: 200
        cellWidth: cellHeight

        model: postsXmlList
        clip: true
        focus: true

        header: pageMenu

        footer: pageMenu

        highlight: Rectangle {
            color: "lightblue"
            radius: 5
            opacity: 0.4
        }

        delegate: Item {

            height: postsView.cellHeight
            width: postsView.cellWidth

            ColumnLayout {
                anchors.margins: 5
                anchors.fill: parent
                spacing: 5

                Image {
                    Layout.preferredWidth: parent.width
                    source: model.preview_url
                    fillMode: Image.PreserveAspectFit
                    BusyIndicator {
                        anchors.centerIn: parent
                        running: parent.status === Image.Loading
                    }
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
        Component {
            id: pageMenu
            Rectangle {
                width: parent.width
                height: 20
                color: "lightblue"
                opacity: 0.8
                Text {
                    anchors.centerIn: parent
                    text: "Page 1"
                }
            }
        }


    }
}

