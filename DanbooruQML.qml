import QtQuick 2.3
import QtQuick.XmlListModel 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

Rectangle {
    id: main
    width: 720
    height: 600

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

   TabView {
       id: mainTab
       anchors.fill: parent
       frameVisible: false
       anchors.margins: 4

       Tab {
           title: "Page 0"
           CurrentPage {
               model: postsXmlList
               anchors.fill: parent
           }
       }

       Tab {
           title: "Next Page"
           MouseArea {
               anchors.fill: parent
               onClicked: console.log("test")
           }
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
           }
           frame: Rectangle { color: "steelblue" }
       }
   }
}

