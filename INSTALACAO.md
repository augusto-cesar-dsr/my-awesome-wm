# 🚀 Instalação - AwesomeWM Dynamic Theme & Picom

## ✅ Script de Instalação Automática

**Data:** 01 de Julho de 2025  
**Compatibilidade:** Ubuntu/Debian e derivados  
**Funcionalidades:** Instalação completa de todos os pré-requisitos

---

## 🎯 O que o Script Instala

### **🔧 Core AwesomeWM:**
- AwesomeWM window manager
- AwesomeWM extras e utilitários
- X11 server (Xorg)
- LightDM display manager
- Lua interpreter e LuaRocks

### **🎨 Compositor e Efeitos Visuais:**
- Picom compositor (sombras, blur, transparências)
- Feh (wallpaper setter e visualizador)
- ImageMagick (manipulação de imagens)

### **📱 Aplicações Essenciais:**
- Gnome Terminal (terminal)
- Nautilus (gerenciador de arquivos)
- Rofi (launcher de aplicações)
- Google Chrome (navegador principal)
- Firefox (navegador fallback)

### **🔊 Sistema de Áudio:**
- PulseAudio (servidor de áudio)
- PavuControl (controle de áudio GUI)
- PasysTray (bandeja do sistema)
- ALSA utilities

### **🌐 Rede e Bluetooth:**
- NetworkManager (gerenciamento de rede)
- NetworkManager applet
- Bluez (stack Bluetooth)
- Blueman (gerenciador Bluetooth)

### **🐍 Python e Tema Dinâmico:**
- Python 3 e pip
- PIL (Python Imaging Library)
- Requests (HTTP library)
- ColorThief (extração de cores)

### **🛠️ Ferramentas de Desenvolvimento:**
- Git (controle de versão)
- Build essentials (compiladores)
- Node.js e npm
- JQ (processador JSON)

### **📝 Aplicações Opcionais:**
- Slack (comunicação)
- Visual Studio Code (editor)
- JetBrains Mono Nerd Font
- Font Awesome (ícones)

---

## 🚀 Como Usar

### **1. Verificar Dependências (Opcional)**
```bash
cd ~/.config/awesome
./check-deps.sh
```

### **2. Executar Instalação Completa**
```bash
cd ~/.config/awesome
./install.sh
```

### **3. Seguir Instruções Pós-Instalação**
- Fazer logout
- Selecionar "awesome" na tela de login
- Fazer login

---

## 📋 Pré-Requisitos do Sistema

### **Sistema Operacional:**
- Ubuntu 20.04+ (LTS recomendado)
- Debian 11+ (Bullseye ou superior)
- Linux Mint 20+
- Pop!_OS 20.04+
- Outros derivados Ubuntu/Debian

### **Hardware Mínimo:**
- **RAM**: 4GB (8GB recomendado)
- **CPU**: Dual-core 2GHz+
- **GPU**: Suporte OpenGL (para Picom)
- **Armazenamento**: 2GB livres

### **Permissões:**
- Usuário com privilégios sudo
- Conexão com internet ativa

---

## 🔧 Detalhes da Instalação

### **Processo Automático:**
1. **Verificação do Sistema** - Compatibilidade e permissões
2. **Backup** - Configuração existente (se houver)
3. **Atualização** - Listas de pacotes do sistema
4. **Instalação Core** - AwesomeWM e dependências básicas
5. **Aplicações** - Programas essenciais
6. **Compositor** - Picom e efeitos visuais
7. **Python** - Bibliotecas para tema dinâmico
8. **Utilitários** - Ferramentas complementares
9. **Opcionais** - Chrome, Slack, VSCode (com confirmação)
10. **Configuração** - Serviços e permissões
11. **Verificação** - Teste de instalação

### **Logs e Backup:**
- **Log de instalação**: `~/.config/awesome/install.log`
- **Backup automático**: `~/.config/awesome-backup-YYYYMMDD-HHMMSS/`

---

## 🧪 Verificação Pós-Instalação

### **Comandos Disponíveis:**
```bash
# Verificar AwesomeWM
awesome --version

# Verificar Picom
picom --version

# Verificar Python PIL
python3 -c "from PIL import Image; print('PIL OK')"

# Verificar tema dinâmico
~/.config/awesome/bin/theme_manager help

# Verificar Picom manager
~/.config/awesome/bin/picom_manager help
```

### **Funcionalidades Testáveis:**
- **Login**: Selecionar "awesome" na tela de login
- **Keybindings**: `Super + s` para ver atalhos
- **Widgets**: 10 widgets na wibar
- **Tema dinâmico**: `Alt + t` para toggle
- **Picom**: `Alt + c` para toggle compositor
- **Scratchpads**: `Alt + 1/2/3` para terminais flutuantes

---

## 🔧 Solução de Problemas

### **Instalação Falha:**
```bash
# Verificar log
cat ~/.config/awesome/install.log

# Verificar dependências manualmente
./check-deps.sh

# Reinstalar pacote específico
sudo apt install --reinstall PACOTE
```

### **AwesomeWM Não Inicia:**
```bash
# Verificar configuração
awesome -k

# Testar em modo debug
awesome --replace &

# Verificar logs do X11
cat ~/.xsession-errors
```

### **Picom Não Funciona:**
```bash
# Testar Picom manualmente
picom --config ~/.config/picom/picom.conf

# Verificar backend
picom --backend xrender

# Verificar logs
~/.config/awesome/bin/picom_manager status
```

### **Tema Dinâmico Falha:**
```bash
# Testar extração de cores
python3 ~/.config/awesome/extract_colors.py /caminho/para/imagem.jpg

# Verificar PIL
python3 -c "from PIL import Image"

# Regenerar tema
~/.config/awesome/bin/theme_manager generate
```

---

## 📦 Instalação Manual (Alternativa)

Se o script automático falhar, você pode instalar manualmente:

### **1. AwesomeWM Core:**
```bash
sudo apt update
sudo apt install awesome awesome-extra xorg lightdm
```

### **2. Picom Compositor:**
```bash
sudo apt install picom
```

### **3. Python e PIL:**
```bash
sudo apt install python3 python3-pip python3-pil imagemagick
```

### **4. Aplicações Básicas:**
```bash
sudo apt install gnome-terminal nautilus rofi feh git curl
```

### **5. Sistema de Áudio:**
```bash
sudo apt install pulseaudio pavucontrol pasystray
```

### **6. Rede e Bluetooth:**
```bash
sudo apt install network-manager-gnome blueman
```

---

## 🎯 Configurações Pós-Instalação

### **1. Configurar LightDM:**
```bash
# Selecionar AwesomeWM como padrão
sudo update-alternatives --config x-session-manager
```

### **2. Configurar Áudio:**
```bash
# Adicionar usuário ao grupo audio
sudo usermod -a -G audio $USER
```

### **3. Configurar Sensores:**
```bash
# Detectar sensores de hardware
sudo sensors-detect --auto
```

### **4. Atualizar Fonts:**
```bash
# Atualizar cache de fontes
fc-cache -fv
```

---

## 📊 Recursos do Sistema

### **Uso Típico de Recursos:**
- **AwesomeWM**: ~50-100 MB RAM
- **Picom**: ~70-150 MB RAM
- **Widgets**: ~20-50 MB RAM
- **Total**: ~150-300 MB RAM

### **Performance:**
- **CPU**: 1-3% em idle
- **GPU**: Mínimo (apenas para compositor)
- **Rede**: Apenas para weather widget
- **Disco**: ~500MB para configuração completa

---

## 🏆 Resultado Final

### **Após Instalação Bem-Sucedida:**
- ✅ **AwesomeWM** funcionando com tema personalizado
- ✅ **10 widgets** funcionais na wibar
- ✅ **Picom compositor** com efeitos visuais
- ✅ **Tema dinâmico** baseado em wallpaper
- ✅ **Scratchpads** para acesso rápido
- ✅ **Keybindings** organizados e funcionais
- ✅ **Auto-start** de aplicações configurado

### **Experiência do Usuário:**
- Interface moderna e elegante
- Efeitos visuais profissionais
- Produtividade otimizada
- Personalização automática
- Performance excelente

---

## 🆘 Suporte

### **Em Caso de Problemas:**
1. **Verificar logs**: `~/.config/awesome/install.log`
2. **Testar dependências**: `./check-deps.sh`
3. **Verificar configuração**: `awesome -k`
4. **Consultar documentação**: `README.md`

### **Recursos Adicionais:**
- **AwesomeWM Wiki**: https://awesomewm.org/
- **Picom GitHub**: https://github.com/yshui/picom
- **Configuração completa**: Todos os arquivos em `~/.config/awesome/`

---

## 🎉 Conclusão

O script de instalação automatiza completamente a configuração de um ambiente AwesomeWM moderno, elegante e funcional. Com uma única execução, você terá:

- **Sistema completo** pronto para uso
- **Efeitos visuais** profissionais
- **Produtividade** otimizada
- **Personalização** automática

**Execute `./install.sh` e tenha uma experiência desktop premium em minutos!** 🚀
