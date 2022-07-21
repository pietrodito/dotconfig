const GETTEXT_DOMAIN = 'my-indicator-extension';

const { GObject, St, Clutter, GLib, Gio } = imports.gi;

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
        return "ShowVPN: " + contentsString ;
    }

    _init() {
        super._init(0.0, _('My Shiny Indicator'));

        this._file = Gio.File.new_for_uri(
             'file:///home/ulys/.config/wireguard/current_vpn');
        let panelButtonText = new St.Label({
                    text : this._read_current_vpn(),
                    y_align: Clutter.ActorAlign.CENTER,
                });
        log('*--* après erreur *--* ');
        this.add_child(panelButtonText);

        let item = new PopupMenu.PopupMenuItem(_('Show Notification'));
        item.connect('activate', () => {
            Main.notify(_('Whatʼs up, folks?'));
        });
        this.menu.addMenuItem(item);
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
