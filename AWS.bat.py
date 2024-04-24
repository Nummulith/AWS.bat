from PyQt5 import QtWidgets, uic
import sys
import subprocess

class Window(QtWidgets.QMainWindow, uic.loadUiType("AWS.bat.ui")[0]):
    def __init__(self):
        super().__init__()
        self.setupUi(self)

        for child in self.findChildren(QtWidgets.QPushButton):
            child.clicked.connect(lambda _, btn=child: self.on_button_clicked(btn))

        self.leStackName.setText("LAB")

    def run(self, args):
        subprocess.run(args, shell=True)

    def keypair(self, action):
        self.run(['keypair.bat', action])

    def cloudformation(self, action):
        self.run(["cloudformation.bat", ".\ec2.yaml", self.leStackName.text(), action])

    def putty_connect(self):
        self.run(['putty_connect.bat', self.leStackName.text()])

    def on_button_clicked(self, button):

        btn = button.objectName()
        if   btn == "pbStart":
            self.keypair("c")
            self.cloudformation("c")
            self.putty_connect()

        elif btn == "pbRestart":
            self.cloudformation("r")
            self.putty_connect()

        elif btn == "pbStop":
            self.cloudformation("d")
            self.keypair("d")
            

        elif btn == "pbKeyPairCreate":
            self.keypair("c")

        elif btn == "pbKeyPairDelete":
            self.keypair("d")

        elif btn == "pbCloudFormationCreate":
            self.cloudformation("c")

        elif btn == "pbCloudFormationDelete":
            self.cloudformation("d")

        elif btn == "pbConnect":
            self.putty_connect()

if __name__ == "__main__":
    app = QtWidgets.QApplication(sys.argv)
    mainWindow = Window()
    mainWindow.show()
    sys.exit(app.exec_())
