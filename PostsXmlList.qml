import QtQuick 2.0
import QtQuick.XmlListModel 2.0

XmlListModel {
    //id: postsXmlList

    //source: "http://konachan.com/post.xml"
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
