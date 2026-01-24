pragma Singleton

import qs.utils
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property alias appearance: adapter.appearance
    property alias bar: adapter.bar

    property bool recentlySaved: false

    ElapsedTimer {
        id: timer
    }

    FileView {
        id: fileView

        path: `${Paths.config}/shell.json`
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            try {
                JSON.parse(text());
            } catch (e) {
                console.log(`Failed to load config ${e.message}`);
            }
        }
        onLoadFailed: err => {
            if (err !== FileViewError.FileNotFound) {
                console.log(`Failed to read config file ${err}`);
            }
        }

        JsonAdapter {
            id: adapter

            property AppearanceConfig appearance: AppearanceConfig {}
            property BarConfig bar: BarConfig {}
        }
    }
}
