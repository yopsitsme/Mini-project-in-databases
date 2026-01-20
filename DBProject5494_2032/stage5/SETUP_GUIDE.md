# Environment Setup

### Prerequisites

- **Node.js**: v14+ (check with `node --version`)
- **npm**: v6+ (check with `npm --version`)
- **PostgreSQL**: Running on localhost:5432

### Installation Steps

#### 1. Install Backend Dependencies

```bash
cd sports-backend
npm install
```

#### 2. Install Frontend Dependencies

```bash
cd sports-frontend
npm install
```

### Database Configuration

Edit `sports-backend/src/config/database.js`:

```javascript
const pool = new Pool({
  user: "postgres", // ← Your PostgreSQL user
  host: "localhost",
  database: "----", // ← Your database name
  password: "---", // ← Your PostgreSQL password
  port: 5432,
});
```

---

## Starting the Application

### Use Two Terminals

**Terminal 1 - Backend:**

```bash
cd sports-backend
npm start
```

**Terminal 2 - Frontend:**

```bash
cd sports-frontend
npm run dev
```


---

## Verifying Setup

### Backend Health Check

1. Backend should output:

```
Connected to PostgreSQL database
Server is running on http://localhost:3001
```

2. Test endpoint:

```bash
curl http://localhost:3001/api/health
# Should return: {"status":"Server is running"}
```

### Frontend Health Check

1. Frontend should output:

```
  ➜  Local:   http://localhost:5173/
```

2. Open http://localhost:5173 in browser
3. You should see the main menu with role selection


---

## Common Issues & Solutions

### Issue: "connect ECONNREFUSED 127.0.0.1:5432"

**Cause**: PostgreSQL not running

**Solution**:

- Start PostgreSQL service
- Or check port isn't already in use

### Issue: "database 'backup_1' does not exist"

**Cause**: Database not found

**Solution**:

- Create database: `createdb backup_1`
- Or update database name in `database.js`

### Issue: "CORS error in browser"

**Cause**: Frontend/Backend URL mismatch

**Solution**:

- Verify backend URL in `src/utils/apiService.js`
- Check CORS middleware in `src/middleware/corsMiddleware.js`

### Issue: "Cannot find module" errors

**Cause**: Dependencies not installed

**Solution**:

```bash
npm install
npm install express cors pg
```

### Issue: Frontend shows blank page

**Cause**: Vite not running or port 5173 in use

**Solution**:

- Kill process on port 5173
- Run `npm run dev` again

---

## Development Workflow

### Daily Development

1. Start backend: `npm start` (from sports-backend)
2. Start frontend: `npm run dev` (from sports-frontend)
3. Make changes
4. Test in browser
5. Commit to git

### Adding Features

1. Create model in `src/models/`
2. Create controller in `src/controllers/`
3. Create routes in `src/routes/`
4. Create API service method
5. Create/update page component
6. Test thoroughly

