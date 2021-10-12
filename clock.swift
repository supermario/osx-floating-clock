import Cocoa

class Clock: NSObject, NSApplicationDelegate {
    var timer : NSWindow?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.initTimer()
    }

    func initLabel(font: NSFont, format: String, interval: TimeInterval) -> NSTextField {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        let label = NSTextField()
        label.font = font
        label.isBezeled = false
        label.isEditable = false
        label.drawsBackground = false
        label.alignment = .center
        label.textColor = NSColor(red: 1, green: 1, blue: 1, alpha: 1-(1/3)*(1/3))

        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            label.stringValue = formatter.string(from: Date())
        }
        timer.tolerance = interval / 10
        timer.fire()

        return label
    }

    func initWindow(rect: NSRect, label: NSTextField) -> NSWindow {
        let window = NSWindow(
            contentRect : rect,
            styleMask   : .borderless,
            backing     : .buffered,
            defer       : true
        )

        window.contentView = label
        window.ignoresMouseEvents = false
        window.isMovableByWindowBackground = true
        window.level = .floating
        window.collectionBehavior = .canJoinAllSpaces
        // window.backgroundColor = NSColor(red: 0, green: 0, blue: 0, alpha: 1/3)
        window.isOpaque = false
        window.backgroundColor = .clear
        window.orderFrontRegardless()

        return window
    }

    func initTimer() {
        let label = self.initLabel(
            font     : NSFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular),
            format   : "YYYY-MM-dd HH:mm",
            interval : 1
        )

        self.timer = self.initWindow(
            rect     : NSMakeRect(100, 870, 180, 23),
            label    : label
        )
    }
}

let app = NSApplication.shared
let clock = Clock()
app.delegate = clock
app.setActivationPolicy(.accessory)
app.run()
