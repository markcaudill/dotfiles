function vim
  if which nvim
      nvim $argv
  else
      vim $argv
  end
end
