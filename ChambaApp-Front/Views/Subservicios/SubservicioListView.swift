import SwiftUI

struct SubservicioListView: View {
    let titulo: String
    @State private var subservicios: [Subservicio] = []

    var body: some View {
        ZStack {
            Color("FondoPrincipal").ignoresSafeArea()

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
        SubservicioService.shared.obtenerSubservicios(categoria: titulo) { resultado, error in
            if let resultado = resultado {
                DispatchQueue.main.async {
                    self.subservicios = resultado
                }
            } else {
                print("Error cargando subservicios:", error?.localizedDescription ?? "Desconocido")
            }
        }
    }
}


