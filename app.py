from fastapi import FastAPI
from database import engine, Base
from routers.alunos import alunos_router
from routers.cursos import cursos_router
from routers.matriculas import matriculas_router


Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="API de Gestão Escolar", 
    description="""
        Esta API fornece endpoints para gerenciar alunos, cursos e turmas, em uma instituição de ensino.  
        
        Permite realizar diferentes operações em cada uma dessas entidades.
    """, 
    version="1.0.0",
)

# Esta é a rota que responde a GET /
@app.get("/")
async def read_root():
    return {"message": "API está funcionando! Olá do Docker!"}

# Exemplo de outra rota (se você tiver uma)
@app.get("/items/{item_id}")
async def read_item(item_id: int, q: str = None):
    return {"item_id": item_id, "q": q}


app.include_router(alunos_router, tags=["alunos"])
app.include_router(cursos_router, tags=["cursos"])
app.include_router(matriculas_router, tags=["matriculas"])