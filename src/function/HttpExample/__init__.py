import azure.functions as func

def main(req: func.HttpRequest) -> func.HttpResponse:
    name = req.params.get('name')
    if not name:
        try:
            req_body = req.get_json()
        except ValueError:
            req_body = {}
        name = req_body.get('name')

    if name:
        return func.HttpResponse(f"Hola {name}! Tu función de Azure está funcionando correctamente infra por ambiente esto es qa update 🎉")
    else:
        return func.HttpResponse(
             "Por favor pasa un nombre en la query string o en el body (JSON) con 'name'",
             status_code=400
        )
