function uu --description "Update and upgrade with apt."
  sudo apt update
  sudo apt upgrade
  sudo apt autoremove
end
