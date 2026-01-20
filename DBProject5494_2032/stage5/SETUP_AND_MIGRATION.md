# Migration & Setup Notes

## Environment Setup

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
  database: "backup_1", // ← Your database name
  password: "1234", // ← Your PostgreSQL password
  port: 5432,
});
```

---

## Starting the Application

### Option 1: Two Terminals (Recommended)

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

### Option 2: Using npm-run-all (if installed)

```bash
npm install -g npm-run-all

# From stage5 directory
npm-run-all --parallel "npm:backend" "npm:frontend"
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

## API Testing

### Using cURL

**Get all teachers:**

```bash
curl http://localhost:3001/api/teachers
```

**Get teacher schedule:**

```bash
curl http://localhost:3001/api/teachers/schedule/1
```

**Create a new student:**

```bash
curl -X POST http://localhost:3001/api/students \
  -H "Content-Type: application/json" \
  -d '{
    "firstName":"John",
    "lastName":"Doe",
    "birthDate":"2005-01-01",
    "email":"john@example.com",
    "phone":"555-1234"
  }'
```

### Using Postman/Insomnia

1. Import the API endpoints from `REFACTORING_GUIDE.md`
2. Set base URL: `http://localhost:3001/api`
3. Test each endpoint

---

## Environment Variables (Optional)

Create `sports-backend/.env`:

```env
DB_USER=postgres
DB_HOST=localhost
DB_NAME=backup_1
DB_PASSWORD=1234
DB_PORT=5432
PORT=3001
```

Update `sports-backend/src/config/database.js`:

```javascript
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});
```

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

## Build for Production

### Backend Build

```bash
cd sports-backend
npm start  # No build needed, runs directly
```

### Frontend Build

```bash
cd sports-frontend
npm run build
# Creates dist/ folder with optimized files
npm run preview  # Preview production build
```

---

## Docker Setup (Optional)

### Backend Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY src ./src
COPY server.js .
EXPOSE 3001
CMD ["npm", "start"]
```

### Docker Compose

```yaml
version: "3.8"
services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: 1234
      POSTGRES_DB: backup_1
    ports:
      - "5432:5432"

  backend:
    build: ./sports-backend
    ports:
      - "3001:3001"
    depends_on:
      - postgres
    environment:
      DB_USER: postgres
      DB_PASSWORD: 1234
      DB_NAME: backup_1

  frontend:
    build: ./sports-frontend
    ports:
      - "5173:5173"
    depends_on:
      - backend
```

Run with: `docker-compose up`

---

## Performance Tips

### Backend

1. Use database indexes on frequently queried columns
2. Implement query caching
3. Add pagination for large datasets
4. Use connection pooling (already implemented)

### Frontend

1. Lazy load routes
2. Optimize images
3. Minimize bundle size
4. Cache API responses

---

## Security Checklist

- [ ] Change database password from default
- [ ] Use environment variables for secrets
- [ ] Implement authentication
- [ ] Add input validation
- [ ] Add rate limiting
- [ ] Use HTTPS in production
- [ ] Add CORS whitelist
- [ ] Sanitize user input
- [ ] Add security headers

---

## Monitoring & Logging

### Enable Request Logging

Already implemented in `middleware/requestLogger.js`:

```
GET /api/teachers - 200 - 45ms
POST /api/students - 201 - 123ms
```

### Add Error Logging

Check console for errors:

```javascript
console.error("Error:", error);
console.log("Request:", req.path);
```

---

## Version Control

### .gitignore

Already handled by Vite and Node templates:

```
node_modules/
dist/
.env
.env.local
.DS_Store
```

### Commit Strategy

```bash
git add src/  # Add organized code
git commit -m "Refactor: split monolithic app into modules"
git push
```

---

## Deployment Options

### Heroku

```bash
heroku create your-app-name
git push heroku main
heroku config:set DATABASE_URL=...
```

### Vercel (Frontend)

```bash
npm i -g vercel
vercel
```

### DigitalOcean/AWS/Azure

1. Deploy backend (Node.js container)
2. Deploy frontend (static site or container)
3. Configure environment variables
4. Set up database

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

---

## Getting Help

### Resources

- [Express.js Docs](https://expressjs.com/)
- [React Docs](https://react.dev/)
- [PostgreSQL Docs](https://www.postgresql.org/docs/)
- [Vite Docs](https://vitejs.dev/)

### Debug Tools

- Node: `node --inspect` (debugging)
- Chrome DevTools (frontend)
- PostgreSQL: `psql` (database client)
- Postman (API testing)

---

## Next Steps

1. ✅ Setup complete
2. Start applications
3. Test all features
4. Add TypeScript
5. Write unit tests
6. Deploy to production

---

**You're ready to go! 🚀**

Questions? Check `QUICK_START.md` or `REFACTORING_GUIDE.md`
