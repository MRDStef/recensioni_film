# Recensioni Film

Applicazione web per la gestione e visualizzazione di recensioni cinematografiche.
Architettura a 3 livelli: **Angular** (frontend) + **Slim PHP** (backend REST API) + **MariaDB** (database).

---

## Ambienti supportati

| Ambiente | Database | Backend | phpMyAdmin |
|----------|----------|---------|------------|
| Windows (XAMPP) | XAMPP | `php -S localhost:8080` | `localhost/phpmyadmin` |
| Linux scuola (Docker) | Container MariaDB | Container Apache | `localhost:8081` |

---

## Windows con XAMPP

### Requisiti
- XAMPP (include PHP, MySQL, phpMyAdmin)
- Composer
- Node.js >= 18
- Angular CLI (`npm install -g @angular/cli`)

### Database
1. Avviare XAMPP e attivare **Apache** e **MySQL**
2. Aprire phpMyAdmin su `http://localhost/phpmyadmin`
3. Creare il database `recensioni_film` ed eseguire lo script SQL del progetto

### Configurazione `.env` backend
Creare il file `.env` nella cartella `Backend_GPOI/php/`:
```
JWT_SECRET=chiave_segreta_lunga_e_casuale
DB_HOST=localhost
DB_NAME=recensioni_film
DB_USER=root
DB_PASS=
```

> Per generare una chiave JWT sicura:
> ```bash
> php -r "echo bin2hex(random_bytes(32));"
> ```

### Installazione dipendenze backend
```bash
cd percorso\Backend_GPOI\php
composer install
composer dump-autoload
```

### Avvio backend
```bash
cd percorso\Backend_GPOI\php\public
php -S localhost:8080
```
> Avviare **dalla cartella `public/`** e lasciare il terminale aperto.

---

## Linux (Docker)

### Requisiti
- Docker e Docker Compose
- Node.js >= 18
- Angular CLI (`npm install -g @angular/cli`)

### Configurazione `.env` Docker
Creare il file `.env` nella root del progetto (stessa cartella di `docker-compose.yml`):
```
MY_UID=1000
MY_GID=1000
```

> Per ottenere il proprio UID e GID eseguire:
> ```bash
> echo "MY_UID=$(id -u) MY_GID=$(id -g)"
> ```

### Configurazione `.env` backend
Creare il file `.env` nella cartella `Backend_GPOI/php/`:
```
JWT_SECRET=chiave_segreta_lunga_e_casuale
DB_HOST=my_mariadb
DB_NAME=scuola
DB_USER=root
DB_PASS=ciccio
```

### Avvio Docker
```bash
docker compose up -d
```

I servizi saranno raggiungibili su:
- **Backend**: `http://localhost:8080`
- **phpMyAdmin**: `http://localhost:8081`

### Spegnere Docker
```bash
docker compose down
```

---

## Frontend (Angular)

1. Entrare nella cartella del frontend:
```bash
cd percorso/frontend
```

2. Installare le dipendenze:
```bash
npm install
```

3. Avviare il server di sviluppo:
```bash
ng serve
```

Il frontend sarà raggiungibile su: `http://localhost:4200`
---

