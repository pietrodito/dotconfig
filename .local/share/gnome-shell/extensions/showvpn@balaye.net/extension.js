const { St, Clutter, GLib, Gio } = imports.gi;
const Main = imports.ui.main;

let panelButton;

function init () {

    const file = Gio.File.new_for_uri('file:///home/ulys/.config/wireguard/current_vpn');

    function read_current_vpn () {
        const [, contents, etag] = file.load_contents(null);
        const decoder = new TextDecoder('utf-8');
        const contentsString = decoder.decode(contents).trim();
        return "VPN: " + contentsString;
    }

    panelButton = new St.Bin({
        style_class : "panel-button",
    });
    let panelButtonText = new St.Label({
        text : read_current_vpn(),
        y_align: Clutter.ActorAlign.CENTER,
    });
    panelButton.set_child(panelButtonText);


    const Mainloop = imports.mainloop;
    let timeout = Mainloop.timeout_add_seconds(3, () => {
        panelButtonText.set_text(read_current_vpn());
        return true;
    });

}

function enable () {
    // Add the button to the panel
    Main.panel._rightBox.insert_child_at_index(panelButton, 0);
}

function disable () {
    // Remove the added button from panel
    Main.panel._rightBox.remove_child(panelButton);
}
