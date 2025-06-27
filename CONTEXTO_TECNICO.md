# AwesomeWM - Contexto Técnico da Configuração

## 🖥️ Informações do Sistema
- **OS:** Linux
- **Usuário:** augusto
- **Home:** /home/augusto
- **Config Path:** /home/augusto/.config/awesome
- **AwesomeWM:** Versão em uso (verificar com `awesome --version`)

## 📁 Estrutura Atual da Configuração

### Arquivos Principais
- `rc.lua` - Arquivo principal de configuração
- `README.md` - Documentação da configuração

### Diretório `bin/` - Scripts Executáveis
- `audio_manager` - Gerenciador de áudio
- `brightness_control` - Controle de brilho
- `logout` - ✅ **RECÉM CORRIGIDO** - Opções de energia com i3lock
- `rofi_change_display` - Opções de display
- `set_lockscreen_wallpaper` - ✅ **NOVO** - Gerenciador de wallpaper do lock

### Diretório `config/` - Configurações Modulares
- `error-handling.lua` - Tratamento de erros
- `variables.lua` - Variáveis globais e configurações
- `rules.lua` - Regras de janelas
- `signals.lua` - Sinais e eventos
- `autostart.lua` - Aplicações que iniciam automaticamente

#### Subdiretório `config/keys/`
- `global.lua` - Atalhos globais
- `client.lua` - Atalhos de cliente
- `client-buttons.lua` - Botões do mouse

#### Subdiretório `config/ui/`
- `menu.lua` - Menu principal
- `wibar.lua` - Barra superior
- `notifications.lua` - Configuração de notificações

### Diretório `themes/`
- `custom/` - Tema personalizado

## 🏷️ Configuração de Tags

### Tags Personalizadas com Ícones
1. **󰨞 Tag 1**: Editor (Nvim/VSCode) + Terminal (primeiro terminal)
2. **󰒱 Tag 2**: Chat (Slack)
3. **󰖟 Tag 3**: Browser (Chrome - sessão trabalho)
4. **󰍹 Tag 4**: Terminal (ícone de terminal)
5. **󰉋 Tag 5**: Arquivos (Nautilus)
6. **󰝚 Tag 6**: Música
7. **󰊻 Tag 7**: Documentos
8. **󰟴 Tag 8**: Configurações
9. **󰐃 Tag 9**: Diversos

### Lógica Inteligente de Terminais
- **Primeiro terminal**: Abre obrigatoriamente na Tag 1 (junto com editor)
- **Terminais subsequentes**: Abrem na tag atual (onde o usuário estiver)

## 🚀 Aplicações Configuradas

### Aplicações Principais
- **Terminal:** `x-terminal-emulator`
- **Editor:** `nvim` (ou $EDITOR)
- **Browser:** `google-chrome-stable --profile-directory='Profile 1'`
- **File Manager:** `nautilus`
- **Modkey:** Super/Windows (Mod4)

### Auto-start (com delays inteligentes)
1. **Nvim** (Tag 1) - delay 2s
2. **Slack** (Tag 2) - delay 4s
3. **Chrome** (Tag 3) - delay 6s com perfil de trabalho

### Aplicações de Sistema
- `nm-applet` - Network manager
- `blueman-applet` - Bluetooth
- `pasystray` - Audio control

## 🎨 Configurações Visuais Atuais

### Layouts Disponíveis
1. `awful.layout.suit.fair`
2. `awful.layout.suit.fair.horizontal`
3. `awful.layout.suit.max`
4. `awful.layout.suit.tile`
5. `awful.layout.suit.floating`

### Wibar (Barra Superior)
- **Posição:** Top
- **Altura:** 18px (mínima para mostrar ícones)
- **Widgets Atuais:**
  - Menu launcher
  - Tag list
  - Prompt box
  - Task list (centro)
  - Keyboard layout
  - System tray
  - Text clock
  - Layout box

## 🔐 Sistema de Lock Screen

### Configuração Atual (RECÉM IMPLEMENTADA)
- **Lock Program:** i3lock (versão 2.14.1)
- **Wallpaper:** `/home/augusto/.config/awesome/lockscreen-wallpaper.png`
- **Redimensionamento:** Automático via ImageMagick
- **Fallback:** Cor sólida (#1e1e2e) se wallpaper não disponível

### Wallpapers Disponíveis
- **Pasta Principal:** `/home/augusto/Imagens/wallpapers/`
- **Wallpapers Encontrados:**
  - `samurai-yellow-moon.jpg`
  - `samurai-red-moon.png` ✅ **ATUAL NO LOCK**
  - `bleach-hueco-mundo.png`
  - `kaiju-n8.jpeg`
  - `kaiju-n8.png`
  - `gldt93.png`
  - `bleach-hueco-mundo.jpg`

## ⌨️ Atalhos Principais Configurados

### Aplicações
- `Super + Return`: Terminal
- `Super + b`: Browser (Chrome)
- `Super + e`: Gerenciador de arquivos (Nautilus)
- `Super + d`: Rofi launcher
- `Super + r`: Prompt de comando

### Sistema
- `Super + Ctrl + r`: Reiniciar AwesomeWM
- `Super + Shift + q`: Sair do AwesomeWM
- `Super + Ctrl + l`: **Lock Screen** ✅ **FUNCIONANDO**

### Gerenciamento Personalizado
- `XF86AudioRaiseVolume/LowerVolume/Mute`: Controle de volume
- `XF86MonBrightnessUp/Down`: Controle de brilho
- `Ctrl + 1`: Opções de display
- `Super + Shift + a`: Gerenciador de áudio

## 🔧 Dependências Instaladas

### Essenciais (Confirmadas)
- ✅ `imagemagick` - Para redimensionamento de imagens
- ✅ `i3lock` - Para lock screen
- ✅ `rofi` - Para menus e launchers
- ✅ `awesome` - Window manager

### Para Implementar Melhorias (Verificar)
- `curl` - Para widgets de API
- `jq` - Para parsing JSON
- `dunst` - Para notificações avançadas
- `picom` - Para transparências/blur
- `lm-sensors` - Para temperatura do sistema
- `acpi` - Para informações de bateria

## 🐛 Problemas Resolvidos Recentemente

### Lock Screen com i3lock
- **Problema:** i3lock não exibia wallpapers, erro com opções de cor
- **Causa:** Versão básica do i3lock sem suporte a opções avançadas
- **Solução:** ✅ Script adaptado para i3lock básico com redimensionamento automático
- **Data:** 27/06/2025

## 📋 Checklist de Funcionalidades

### ✅ Funcionando
- [x] Configuração modular organizada
- [x] Tags com ícones personalizados
- [x] Auto-start inteligente de aplicações
- [x] Lock screen com wallpaper
- [x] Scripts de gerenciamento de energia
- [x] Atalhos de teclado personalizados
- [x] Integração com tmux (documentada)

### 🔄 Para Melhorar
- [ ] Widgets avançados na wibar
- [ ] Sistema de notificações
- [ ] Scratchpads
- [ ] Tema visual mais moderno
- [ ] Wallpapers dinâmicos
- [ ] Scripts de produtividade

## 💾 Comandos de Backup

### Backup Completo
```bash
cp -r ~/.config/awesome ~/.config/awesome.backup.$(date +%Y%m%d_%H%M%S)
```

### Backup Apenas Configurações
```bash
tar -czf ~/awesome-config-backup-$(date +%Y%m%d_%H%M%S).tar.gz -C ~/.config awesome
```

---

**Última atualização:** 27/06/2025 21:00 UTC
**Próxima revisão:** Quando implementar melhorias da lista TODO
