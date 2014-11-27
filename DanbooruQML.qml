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

    CurrentPage {
        model: postsXmlList
        anchors.fill: parent
    }
}

