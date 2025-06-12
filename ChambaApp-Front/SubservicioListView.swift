




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
                            VStack(spacing: 12) {
                                // Título del subservicio
                                Text(item.nombre)
                                    .font(.headline)
                                    .foregroundColor(Color("TextoPrincipal"))
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(Color("Acento"))
                                    .cornerRadius(12)

                                // Imagen
                                AsyncImage(url: item.imagenURL) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(maxWidth: 250, maxHeight: 160)
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
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 24)
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
                    imagenURL: URL(string: "https://cdn.pixabay.com/photo/2017/01/06/19/15/kids-1959827_960_720.jpg")!
                ),
                Subservicio(
                    id: UUID(),
                    nombre: "Limpieza",
                    imagenURL: URL(string: "https://cdn.pixabay.com/photo/2016/03/26/13/09/cleaning-1280580_960_720.jpg")!
                ),
                Subservicio(
                    id: UUID(),
                    nombre: "Jardinería",
                    imagenURL: URL(string: "https://cdn.pixabay.com/photo/2017/02/01/22/02/gardening-2036450_960_720.jpg")!
                )
            ]
        case "Empresarial":
            subservicios = [
                Subservicio(
                    id: UUID(),
                    nombre: "Limpieza de oficinas",
                    imagenURL: URL(string: "https://cdn.pixabay.com/photo/2018/04/18/18/56/cleaning-3334801_960_720.jpg")!
                )
            ]
        case "Otros":
            subservicios = [
                Subservicio(
                    id: UUID(),
                    nombre: "Soporte técnico",
                    imagenURL: URL(string: "https://cdn.pixabay.com/photo/2016/10/31/18/14/tools-1783901_960_720.jpg")!
                )
            ]
        default:
            subservicios = []
        }
    }
}
