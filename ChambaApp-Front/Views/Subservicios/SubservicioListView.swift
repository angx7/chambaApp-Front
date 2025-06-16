import SwiftUI

struct SubservicioListView: View {
    let titulo: String
    @State private var subservicios: [Subservicio] = []
    
    var body: some View {
        ZStack {
            Color("FondoPrincipal")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 40) {
                    Text(titulo.uppercased())
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color("TextoPrincipal"))
                        .padding(.top, 50)
                    
                    ForEach(subservicios) { item in
                        NavigationLink(destination: PrestadoresListView(titulo: item.nombre)) {
                            SubservicioRowView(subservicio: item)
                        }
                        
                    }
                    
                    Spacer(minLength: 50)
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onAppear {
            cargarSubservicios()
        }
    }
    
    func cargarSubservicios() {
        switch titulo {
        case "Doméstico":
            subservicios = [
                Subservicio(
                    id: UUID(),
                    nombre: "Cuidado de niños",
                    descripcion: "Cuidado amable y responsable de menores en el hogar.",
                    imagenURL: URL(string: "https://st.depositphotos.com/18722762/61617/v/1600/depositphotos_616175984-stock-illustration-babysitter-nanny-services-care-provide.jpg")!
                ),
                Subservicio(
                    id: UUID(),
                    nombre: "Limpieza",
                    descripcion: "Limpieza general de habitaciones, baños y cocina.",
                    imagenURL: URL(string: "https://cdn.pixabay.com/photo/2016/03/26/13/09/cleaning-1280580_960_720.jpg")!
                ),
                Subservicio(
                    id: UUID(),
                    nombre: "Jardinería",
                    descripcion: "Corte de pasto, poda y mantenimiento de áreas verdes.",
                    imagenURL: URL(string: "https://cdn.pixabay.com/photo/2017/02/01/22/02/gardening-2036450_960_720.jpg")!
                )
            ]
        case "Empresarial":
            subservicios = [
                Subservicio(
                    id: UUID(),
                    nombre: "Limpieza de oficinas",
                    descripcion: "Servicio de aseo profesional para espacios corporativos.",
                    imagenURL: URL(string: "https://cdn.pixabay.com/photo/2018/04/18/18/56/cleaning-3334801_960_720.jpg")!
                )
            ]
        case "Otros":
            subservicios = [
                Subservicio(
                    id: UUID(),
                    nombre: "Soporte técnico",
                    descripcion: "Diagnóstico y reparación de equipos tecnológicos.",
                    imagenURL: URL(string: "https://cdn.pixabay.com/photo/2016/10/31/18/14/tools-1783901_960_720.jpg")!
                )
            ]
        default:
            subservicios = []
        }
    }
    
}


struct SubservicioRowView: View {
    let subservicio: Subservicio
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Imagen
            AsyncImage(url: subservicio.imagenURL) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(12)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }

            // Texto
            VStack(alignment: .leading, spacing: 6) {
                Text(subservicio.nombre)
                    .font(.headline)
                    .foregroundColor(Color("TextoPrincipal"))

                Text(subservicio.descripcion)
                    .font(.subheadline)
                    .foregroundColor(Color("TextoPrincipal")) 
                    .multilineTextAlignment(.leading) // << Este es CLAVE
            }
            .frame(maxWidth: .infinity, alignment: .leading) // << También este
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .background(Color.white.opacity(0.2))
        .cornerRadius(16)
        .shadow(radius: 3)
        .padding(.horizontal, 20)
    }
}
