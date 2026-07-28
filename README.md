# TecnoCorp - Servidor Linux Empresarial Seguro
Proyecto de implementación de un servidor Linux empresarial para TecnoCorp.
El servidor integra servicios de red, seguridad de archivos, servidor web HTTPS,
contenedores Docker, auditoría, monitoreo, backups, firewall y automatización
mediante Bash.
## Arquitectura del laboratorio
- Servidor: Debian GNU/Linux
- IP del servidor: 192.168.10.1
- Red interna: 192.168.10.0/24
- Cliente Debian: 192.168.10.25
- Dominio local: empresa.local
- Servidor web: www.empresa.local
## 1. Infraestructura base
Se configuraron los servicios DHCP y DNS.
### DHCP
El servidor proporciona configuración de red a los clientes de la red interna.
### DNS
Se configuró BIND9 para resolver el dominio:
www.empresa.local -> 192.168.10.1
Las configuraciones utilizadas se encuentran en:
configuraciones/
## 2. Seguridad de archivos
Se creó la estructura:
/empresa/
- sistemas/
- ventas/
- gerencia/
Se utilizaron:
- Usuarios y grupos
- Permisos Linux
- SGID
- ACL
- Principio de privilegio mínimo
Gerencia dispone de acceso transversal mediante ACL, mientras que los usuarios
de otros departamentos tienen acceso restringido.
## 3. Servidor web seguro
Se implementó Apache con HTTPS y TLS.
Dirección:
https://www.empresa.local
El certificado utiliza:
CN = www.empresa.local
SAN = DNS:www.empresa.local
Apache está configurado para utilizar HTTPS mediante el puerto 443 y el acceso
HTTP por el puerto 80 fue deshabilitado.
## 4. Docker y Nginx
Se instaló Docker y se desplegó un contenedor Nginx.
Se creó el volumen:
nginx_data
El contenido web permanece disponible aunque el contenedor sea eliminado y
creado nuevamente utilizando el mismo volumen.
Por seguridad, Nginx está publicado solamente en:
127.0.0.1:8080
## 5. Auditoría y monitoreo
Se configuró auditd para vigilar:
- /etc/passwd
- /etc/shadow
Las modificaciones pueden consultarse mediante ausearch.
También se utilizó htop para monitorear:
- CPU
- Memoria RAM
- Procesos
- Usuarios
- Carga del sistema
## 6. Backups
Se implementaron respaldos de:
/empresa/
utilizando rsync.
Destino:
/backup/empresa/
El respaldo está automatizado mediante cron todos los días a las 02:00.
También se realizó una prueba de restauración de un archivo eliminado.
## 7. Firewall y Hardening
Se configuró UFW con política:
deny incoming
allow outgoing
Servicios permitidos:
- SSH: TCP 22
- DNS: TCP/UDP 53
- HTTPS: TCP 443
- DHCP: UDP 67
También se verificó AppArmor con perfiles activos en modo enforce.
## 8. Automatización Bash
Se desarrolló:
scripts/crear_usuario.sh
El script recibe un nombre de usuario y un departamento.
Ejemplo:
sudo ./crear_usuario.sh empleado1 ventas
El script:
- Comprueba los parámetros.
- Comprueba que el departamento exista.
- Comprueba que el usuario no exista.
- Crea el usuario.
- Crea su directorio personal.
- Lo asigna al grupo correspondiente.
## Evidencias
Las capturas de las pruebas realizadas se almacenarán en:
evidencias/
Incluyen pruebas de:
- DHCP y DNS
- SGID y ACL
- HTTPS/TLS
- Docker y persistencia
- auditd
- htop
- rsync y cron
- UFW
- AppArmor
- Script Bash
## Estructura del repositorio
tecnocorp-servidor/
├── configuraciones/
├── scripts/
├── evidencias/
└── README.md
## Seguridad
Por motivos de seguridad, este repositorio no incluye claves privadas,
contraseñas ni archivos sensibles del servidor.
No se incluyen archivos como:
- empresa.key
- rndc.key
- /etc/shadow
