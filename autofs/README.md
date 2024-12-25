## Automatic mount with systemd 

[Blog Thomas Tomecek](https://blog.tomecek.net/post/automount-with-systemd)

### Sur le Nas Synology

Adresse : 192.168.1.34:5000 admin/sesame311

Panneau de configuration > Service de fichiers > SMB/AFP/NFS
- Cocher Activer le server NFS
- edit permissions for shared folders   volume1/Backup

### Sur le serveur Linux

Pre requis 
- Installer  sudo apt install nfs-common
- Créer un point de montage : sudo mkdir -p /mnt/synology

Les noms de fichiers sont déduits du point de montage
Recoper les fichiers 
- sudo cp mnt-synology.autoount /etc/systemd/system/
- sudo cp mnt-synology.mount    /etc/systemd/system/

relancer pour tenir compte du changement : sudo sytemctl daemon-reload

Les commandes: status, start, stop pour le service

```
 sudo systemctl status mnt-synology.automount

```

Pour démarrer manuellement apres un boot : sudo systemctl start mnt-synology.automount


Pour démarrer automatqiuement le service apres le boot

```
  sudo systemctl enable mnt-synology.automount

```

