$env.config = {
  show_banner: false,
  table: {
    mode: "compact"
  }
  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "fuzzy"
    external: {
      enable: true 
      max_results: 100 
      completer: { |spans|
        carapace $spans.0 nushell $spans | from json
      }
    }
  }
} 
$env.PATH = (
  $env.PATH
  | split row (char esep)
  | prepend /home/myuser/.apps
  | append /usr/bin/env
)

fastfetch
