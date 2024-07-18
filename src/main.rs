use actix_web::{web, App, HttpServer, Responder};
use chrono::Utc;
use serde::Serialize;
use std::env;

#[derive(Serialize)]
struct ApiResponse {
    version: String,
    timestamp: String,
    queue_services: String,
    data_services: String,
}

async fn get_api_info() -> impl Responder {
    let response = ApiResponse {
        version: "3.11.0".to_string(),
        timestamp: Utc::now().format("%Y-%m-%d %H:%M:%S").to_string(),
        queue_services: "ok".to_string(),
        data_services: "ok".to_string(),
    };
    web::Json(response)
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    // Define the port
    let port = env::var("PORT").unwrap_or_else(|_| "4444".to_string());
    let address = format!("127.0.0.1:{}", port);

    // Print the message
    println!("The server is running on {}", address);

    // Start the server
    HttpServer::new(|| App::new().route("/api", web::get().to(get_api_info)))
        .bind(&address)?
        .run()
        .await
}
