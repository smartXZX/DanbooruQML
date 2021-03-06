import QtQuick 2.3
import QtQuick.XmlListModel 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {
    id: main
    width: 720
    height: 600

    function createXMLList(page) {
        var component = Qt.createComponent("PostsXmlList.qml")
        var sprite = component.createObject()
        sprite.source = "http://konachan.com/post.xml?page=" + page
        console.log("loaded")
        return sprite
    }

    function createPage(tab, page){
        var component = Qt.createComponent("CurrentPage.qml")
        var sprite = component.createObject(tab)
        sprite.model = createXMLList(page)
        //sprite.anchors = {fill: parent}
    }

    TabView {
        id: mainTab
        anchors.fill: parent
        frameVisible: false
        anchors.margins: 4

        Tab {
            id: next
            title: "Next Page"
        }

        Component.onCompleted: {
            createPage(mainTab.insertTab(mainTab.count, "Page 0"), 0)
            mainTab.currentIndex = 0
        }

        style: TabViewStyle {
            frameOverlap: 1
            tab: Rectangle {
                color: styleData.selected ? "darkgrey" : "steelblue"
                //border.color: "steelblue"
                implicitWidth: Math.max(text.width + 4, 80)
                implicitHeight: 20
                radius: 3
                Text {
                    id: text
                    anchors.centerIn: parent
                    text: styleData.title
                    color: styleData.selected ? "white" : "black"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: if (styleData.index === (mainTab.count - 1)) {
                                   console.log("test")
                                   //createPage(mainTab)
                                   createPage(mainTab.insertTab(mainTab.count - 1, "Page %1".arg(mainTab.count - 1)),mainTab.count - 1)
                                   mainTab.currentIndex = mainTab.count - 2
                               }
                               else {mainTab.currentIndex = styleData.index}
                }
            }
            frame: Rectangle { color: "steelblue" }
            tabBar: Rectangle { color: "lightgrey" }
        }
    }
}

