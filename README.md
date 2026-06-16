# My Nix Dotfiles
## Rules
- Each `*.nix` file should only configure one service 

## File Structure
```
├── README.md
├── TODO.md
├── config // configuration options
├── files // configuration files without nix files
├── flake.in.nix
├── flake.nix
├── hosts // host configurations
├── modules
│   ├── shared
│   ├── darwin // darwin modules
│   ├── home // home-manager modules
│   ├── linux // linux modules
│   └── server // server modules
├── overlays
├── secrets
└── util
```
## Options
- https://nix-community.github.io/home-manager/options.xhtml
- https://nix-darwin.github.io/nix-darwin/manual/index.html
## Credits
- https://github.com/max-baz/dotfiles
- https://github.com/eh8/chenglab
