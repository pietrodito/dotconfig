const GETTEXT_DOMAIN = 'my-indicator-extension';

const { GObject, St, Clutter, GLib, Gio } = imports.gi;

const Util = imports.misc.util;

const Mainloop = imports.mainloop;

const ExtensionUtils = imports.misc.extensionUtils;
const Main = imports.ui.main;
const PanelMenu = imports.ui.panelMenu;
const PopupMenu = imports.ui.popupMenu;

const _ = ExtensionUtils.gettext;

const Indicator = GObject.registerClass(
class Indicator extends PanelMenu.Button {


    _read_current_vpn () {

        const [, contents, etag] = this._file.load_contents(null);
        const decoder = new TextDecoder('utf-8');
        const contentsString = decoder.decode(contents).trim();
        return "VPN: " + contentsString ;
    }

    _init() {
        super._init(0.0, _('My Shiny Indicator'));

        this._file = Gio.File.new_for_uri(
             'file:///home/ulys/.config/wireguard/.current_vpn');
        let panelButtonText = new St.Label({
                    text : this._read_current_vpn(),
                    y_align: Clutter.ActorAlign.CENTER
                });

        this.add_child(panelButtonText);

        var files_string = GLib.spawn_command_line_sync(
            "ls .config/wireguard/")[1].toString().trim();

        var files = files_string.split("\n");

        for (let i in files) {
            var item = new PopupMenu.PopupMenuItem(_(files[i]));
            item.connect('activate',
               () => {Util.spawn(['vpn', files[i]]);});
            this.menu.addMenuItem(item);
        }

        let timeout = Mainloop.timeout_add_seconds(3, () => {
            panelButtonText.set_text(this._read_current_vpn())
            return true;
         });
    }
});

class Extension {
    constructor(uuid) {
        this._uuid = uuid;

        ExtensionUtils.initTranslations(GETTEXT_DOMAIN);
    }

    enable() {
        this._indicator = new Indicator();
        Main.panel.addToStatusArea(this._uuid, this._indicator);
    }

    disable() {
        this._indicator.destroy();
        this._indicator = null;
    }
}

function init(meta) {
    return new Extension(meta.uuid);
}
