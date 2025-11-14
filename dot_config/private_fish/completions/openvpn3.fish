# Main openvpn3 command completions - dispatches to subcommands
complete -c openvpn3 -f

# Subcommands
complete -c openvpn3 -n "not __fish_seen_subcommand_from session-start session-manage sessions-list
  config-import configs-list config-remove config-manage config-acl config-dump session-stats session-acl
  session-auth log autoload" -a session-start -d "Start VPN session"
complete -c openvpn3 -n "not __fish_seen_subcommand_from session-start session-manage sessions-list
  config-import configs-list config-remove config-manage config-acl config-dump session-stats session-acl
  session-auth log autoload" -a session-manage -d "Manage VPN sessions"
complete -c openvpn3 -n "not __fish_seen_subcommand_from session-start session-manage sessions-list
  config-import configs-list config-remove config-manage config-acl config-dump session-stats session-acl
  session-auth log autoload" -a sessions-list -d "List active sessions"
complete -c openvpn3 -n "not __fish_seen_subcommand_from session-start session-manage sessions-list
  config-import configs-list config-remove config-manage config-acl config-dump session-stats session-acl
  session-auth log autoload" -a config-import -d "Import configuration"
complete -c openvpn3 -n "not __fish_seen_subcommand_from session-start session-manage sessions-list
  config-import configs-list config-remove config-manage config-acl config-dump session-stats session-acl
  session-auth log autoload" -a configs-list -d "List configurations"
complete -c openvpn3 -n "not __fish_seen_subcommand_from session-start session-manage sessions-list
  config-import configs-list config-remove config-manage config-acl config-dump session-stats session-acl
  session-auth log autoload" -a config-remove -d "Remove configuration"
complete -c openvpn3 -n "not __fish_seen_subcommand_from session-start session-manage sessions-list
  config-import configs-list config-remove config-manage config-acl config-dump session-stats session-acl
  session-auth log autoload" -a config-manage -d "Manage configurations"
complete -c openvpn3 -n "not __fish_seen_subcommand_from session-start session-manage sessions-list
  config-import configs-list config-remove config-manage config-acl config-dump session-stats session-acl
  session-auth log autoload" -a session-stats -d "Session statistics"
complete -c openvpn3 -n "not __fish_seen_subcommand_from session-start session-manage sessions-list
  config-import configs-list config-remove config-manage config-acl config-dump session-stats session-acl
  session-auth log autoload" -a log -d "Receive log events"

# Delegate to existing subcommand completions
complete -c openvpn3 -n "__fish_seen_subcommand_from session-start" -w openvpn3-session-start
complete -c openvpn3 -n "__fish_seen_subcommand_from session-manage" -w openvpn3-session-manage
complete -c openvpn3 -n "__fish_seen_subcommand_from sessions-list" -w openvpn3-sessions-list
complete -c openvpn3 -n "__fish_seen_subcommand_from config-import" -w openvpn3-config-import
complete -c openvpn3 -n "__fish_seen_subcommand_from configs-list" -w openvpn3-configs-list
complete -c openvpn3 -n "__fish_seen_subcommand_from config-remove" -w openvpn3-config-remove
complete -c openvpn3 -n "__fish_seen_subcommand_from config-manage" -w openvpn3-config-manage
complete -c openvpn3 -n "__fish_seen_subcommand_from session-stats" -w openvpn3-session-stats
complete -c openvpn3 -n "__fish_seen_subcommand_from log" -w openvpn3-log
