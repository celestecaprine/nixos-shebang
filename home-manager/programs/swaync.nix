{pkgs, ...}:

{
  home.packages = with pkgs; [ swaynotificationcenter ];
  home.file = {
    ".config/swaync/style.css".text = ''
    /*
 * vim: ft=less
 */

@define-color cc-bg rgba(0, 0, 0, 0.7);

@define-color noti-border-color rgb(137, 180, 250);
@define-color noti-bg rgba(30, 30, 46, 0.9);
@define-color noti-bg-hover rgba(30, 30, 46, 0.95);
@define-color noti-bg-focus rgba(30, 30, 46, 0.95);
@define-color noti-close-bg rgba(255, 255, 255, 0.1);
@define-color noti-close-bg-hover rgba(255, 255, 255, 0.15);

@define-color bg-selected rgb(0, 128, 255);

.notification-row {
  outline: none;
}

.notification-row:focus,
.notification-row:hover {
  background: @noti-bg-focus;
}

.notification {
  border-radius: 0px;
  margin: 6px 12px;
  box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.3), 0 1px 3px 1px rgba(0, 0, 0, 0.7),
    0 2px 6px 2px rgba(0, 0, 0, 0.3);
  padding: 0;
  font-family: "Fira Mono";
}

/* Uncomment to enable specific urgency colors
.low {
  background: yellow;
  padding: 6px;
  border-radius: 12px;
}

.normal {
  background: green;
  padding: 6px;
  border-radius: 12px;
}

.critical {
  background: red;
  padding: 6px;
  border-radius: 12px;
}
*/

.notification-content {
  background: transparent;
  padding: 6px;
  border-radius: 0px;
}

.close-button {
  background: @noti-close-bg;
  color: white;
  text-shadow: none;
  padding: 0;
  border-radius: 100%;
  margin-top: 10px;
  margin-right: 16px;
  box-shadow: none;
  border: none;
  min-width: 24px;
  min-height: 24px;
}

.close-button:hover {
  box-shadow: none;
  background: @noti-close-bg-hover;
  transition: all 0.15s ease-in-out;
  border: none;
}

.notification-default-action,
.notification-action {
  padding: 4px;
  margin: 0;
  box-shadow: none;
  background: @noti-bg;
  border: 1px solid @noti-border-color;
  color: white;
}

.notification-default-action:hover,
.notification-action:hover {
  -gtk-icon-effect: none;
  background: @noti-bg-hover;
}

.notification-default-action {
  border-radius: 0px;
}

/* When alternative actions are visible */
.notification-default-action:not(:only-child) {
  border-bottom-left-radius: 0px;
  border-bottom-right-radius: 0px;
}

.notification-action {
  border-radius: 0px;
  border-top: none;
  border-right: none;
}

/* add bottom border radius to eliminate clipping */
.notification-action:first-child {
  border-bottom-left-radius: 10px;
}

.notification-action:last-child {
  border-bottom-right-radius: 10px;
  border-right: 1px solid @noti-border-color;
}

.image {
}

.body-image {
  margin-top: 6px;
  background-color: white;
  border-radius: 12px;
}

.summary {
  font-size: 16px;
  font-weight: bold;
  background: transparent;
  color: white;
  text-shadow: none;
}

.time {
  font-size: 16px;
  font-weight: bold;
  background: transparent;
  color: white;
  text-shadow: none;
  margin-right: 18px;
}

.body {
  font-size: 15px;
  font-weight: normal;
  background: transparent;
  color: white;
  text-shadow: none;
}

/* The "Notifications" and "Do Not Disturb" text widget */
.top-action-title {
  color: white;
  text-shadow: none;
}

.control-center {
  background: @cc-bg;
}

.control-center-list {
  background: transparent;
}

.floating-notifications {
  background: transparent;
}

/* Window behind control center and on all other monitors */
.blank-window {
  background: rgba(30, 30, 46, 0.5);
}

/*** Widgets ***/

/* Title widget */
.widget-title {
  margin: 8px;
  font-size: 1.5rem;
}
.widget-title > button {
  font-size: initial;
  color: white;
  text-shadow: none;
  background: @noti-bg;
  border: 1px solid @noti-border-color;
  box-shadow: none;
  border-radius: 12px;
}
.widget-title > button:hover {
  background: @noti-bg-hover;
}

/* DND widget */
.widget-dnd {
  margin: 8px;
  font-size: 1.1rem;
}
.widget-dnd > switch {
  font-size: initial;
  border-radius: 12px;
  background: @noti-bg;
  border: 1px solid @noti-border-color;
  box-shadow: none;
}
.widget-dnd > switch:checked {
  background: @bg-selected;
}
.widget-dnd > switch slider {
  background: @noti-bg-hover;
  border-radius: 12px;
}

/* Label widget */
.widget-label {
  margin: 8px;
}
.widget-label > label {
  font-size: 1.1rem;
}

/* Mpris widget */
.widget-mpris {
  /* The parent to all players */
}
.widget-mpris-player {
  padding: 8px;
  margin: 8px;
}
.widget-mpris-title {
  font-weight: bold;
  font-size: 1.25rem;
}
.widget-mpris-subtitle {
  font-size: 1.1rem;
}
    '';
  };
}