default:
  just --list

config:
  @keyd check ./default.conf
  @mkdir -p /etc/keyd
  sudo install -m 644 ./default.conf /etc/keyd
  sudo systemctl restart keyd

unset-config:
  sudo rm -i /etc/keyd/default.conf
  sudo systemctl restart keyd

reload:
  keyd reload

show-keycodes:
  sudo keyd monitor
