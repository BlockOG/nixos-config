import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

PanelWindow {
	anchors {
		top: true
		left: true
		right: true
	}

	implicitHeight: 30
	color: "#1e1e2e"

	RowLayout {
		anchors.fill: parent
		spacing: 0

		Rectangle {
			color: "transparent"
			implicitWidth: children[0].implicitWidth + 10
			implicitHeight: 30

			Text {
				anchors.centerIn: parent
				color: "#cdd6f4"
				text: ToplevelManager.activeToplevel.title
			}
		}

		Rectangle {
			color: "transparent"
			Layout.fillWidth: true
		}

		Rectangle {
			color: "transparent"
			implicitWidth: children[0].implicitWidth + 10
			implicitHeight: 30

			Text {
				anchors.centerIn: parent
				id: internetText
				color: "#cdd6f4"
				text: ssid != "" ? wifiStrength != null ? ssid + " " + Math.min(Math.max(Math.round((wifiStrength + 90) / 60 * 10) * 10, 0), 100) + "%" : ssid : "no internet"

				property string ssid: ""
				property list<int> wifiStrengths: []
				property var wifiStrength: {
					if (wifiStrengths.length == 0) return null;
					let sum = 0;
					for (const v of wifiStrengths) sum += v;
					return sum / wifiStrengths.length;
				}

				Process {
					id: ssidProcess
					running: true
					command: ["wpa_cli", "status"]

					stdout: StdioCollector {
						onStreamFinished: {
							if (!text.trim()) return;
							internetText.ssid = "";
							for (const line of text.split("\n")) {
								if (line.startsWith("ssid")) {
									internetText.ssid = line.slice(5);
									break;
								}
							}
						}
					}
				}
				
				FileView {
					id: wifiStrengthFile
					path: Qt.resolvedUrl("/proc/net/wireless")
				}

				Timer {
					interval: 1000
					running: true
					repeat: true

					onTriggered: {
						wifiStrengthFile.reload();
						const lines = wifiStrengthFile.text().split("\n");
						if (lines.length < 3) internetText.wifiStrengths = [];
						else internetText.wifiStrengths.push(lines.length < 3 ? null : parseFloat(lines[2].split(/ +/)[3]));
						if (internetText.wifiStrengths.length > 1) internetText.wifiStrengths = internetText.wifiStrengths.slice(1);
						
						ssidProcess.running = true;
					}
				}
			}

			Rectangle {
				anchors.bottom: parent.bottom
				anchors.left: parent.left
				anchors.right: parent.right
				color: "#5bcefa"
				height: 2
			}
		}

		Rectangle {
			color: "transparent"
			implicitWidth: children[0].implicitWidth + 10
			implicitHeight: 30

			Text {
				anchors.centerIn: parent
				color: Pipewire.defaultAudioSink.audio.muted ? "#f38ba8" : "#cdd6f4"
				text: "%1%".arg(Math.round(Pipewire.defaultAudioSink.audio.volume * 100))

				PwObjectTracker {
					objects: [Pipewire.defaultAudioSink]
				}
			}

			Rectangle {
				anchors.bottom: parent.bottom
				anchors.left: parent.left
				anchors.right: parent.right
				color: "#f5a9b8"
				height: 2
			}
		}

		Rectangle {
			color: "transparent"
			implicitWidth: children[0].implicitWidth + 10
			implicitHeight: 30

			Text {
				anchors.centerIn: parent
				id: brightnessText
				color: "#cdd6f4"
				text: "%1%".arg(Math.round(brightness / maxBrightness * 100))

				property int brightness: 1
				property int maxBrightness: 1

				Process {
					id: brightnessProcess
					running: true
					command: ["brightnessctl", "i", "-m"]

					stdout: StdioCollector {
						onStreamFinished: {
							if (!text.trim()) return;
							const parts = text.split(",");
							if (parts.length < 5) return;
							brightnessText.brightness = parseInt(parts[2]);
							brightnessText.maxBrightness = parseInt(parts[4]);
						}
					}
				}

				Timer {
					interval: 1000
					running: true
					repeat: true

					onTriggered: brightnessProcess.running = true
				}
			}

			Rectangle {
				anchors.bottom: parent.bottom
				anchors.left: parent.left
				anchors.right: parent.right
				color: "#ffffff"
				height: 2
			}
		}

		Rectangle {
			color: "transparent"
			implicitWidth: children[0].implicitWidth + 10
			implicitHeight: 30

			Text {
				anchors.centerIn: parent
				color: UPower.displayDevice.state == UPowerDeviceState.Charging ? "#a6e3a1" : "#cdd6f4"
				text: "%1%".arg(Math.round(UPower.displayDevice.percentage * 100))
			}

			Rectangle {
				anchors.bottom: parent.bottom
				anchors.left: parent.left
				anchors.right: parent.right
				color: "#f5a9b8"
				height: 2
			}
		}

		Rectangle {
			color: "transparent"
			implicitWidth: children[0].implicitWidth + 10
			implicitHeight: 30

			Text {
				anchors.centerIn: parent
				color: "#cdd6f4"
				text: Qt.formatDateTime(clock.date, "yyyy/MM/dd hh:mm:ss")

				SystemClock {
					id: clock
					precision: SystemClock.Seconds
				}
			}

			Rectangle {
				anchors.bottom: parent.bottom
				anchors.left: parent.left
				anchors.right: parent.right
				color: "#5bcefa"
				height: 2
			}
		}
	}
}
