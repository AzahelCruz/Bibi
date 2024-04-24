import SwiftUI

struct ContentView: View {
    @State private var messageText = ""
    @State var messages: [String] = ["Bienvenido a hablar con Bibi"]
    
    var body: some View {
        VStack {
            HStack {
               Image("BiBi")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 100)
                .foregroundColor(Color.blue)            }
            
            ScrollView {
                ForEach(messages, id: \.self) { message in
                    // If the message contains [USER], that means it's us
                    if message.contains("[USER]") {
                        let newMessage = message.replacingOccurrences(of: "[USER]", with: "")
                        
                        // User message styles
                        HStack {
                            Spacer()
                            Text(newMessage)
                                .padding()
                                .foregroundColor(Color.blue)
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                        }
                    } else {
                        
                        // Bot message styles
                        HStack {
                            Text(message)
                                .padding()
                                .background(Color.blue.opacity(0.15))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                            Spacer()
                        }
                    }
                    
                }.rotationEffect(.degrees(180))
            }
            .rotationEffect(.degrees(180))
            .background(Color.gray.opacity(0.1))
            
            
            // Contains the Message bar
            HStack {
                TextField("Type something", text: $messageText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onSubmit {
                        sendMessage(message: messageText)
                    }
                
                Button {
                    sendMessage(message: messageText)
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                .font(.system(size: 26))
                .padding(.horizontal, 10)
            }
            .padding()
        }
    }
    
    func sendMessage(message: String) {
        messages.append("[USER]" + message)
        self.messageText = ""
        
        DispatchQueue.main.async {
            messages.append(getBotResponse(message: message))
        }
    }
    
    func getBotResponse(message: String) -> String {
        let tempMessage = message.lowercased()
        
        if tempMessage.contains("hola") {
            return "¡Hola , como te puedo ayudar el diua de hoy !"
        } else if tempMessage.contains("muchas gracias por ayudarme") {
            return "¡Hasta luego, aqui estare cuando me necesites!"
        } else if tempMessage.contains("tengo una duda sobre un tema") {
            return "Si claro dime , cual es la duda?"
        }else if tempMessage.contains("las tarjetas de debito tienen anualidad"){
            return "No, esta es una de las ventajas de la tarjeta de débito. Generalmente no cobra una anualidad ni una comisión"
        }else if tempMessage.contains("se puede comprar si no tengo saldo en mi tarjeta de debito"){
            return "No, ninguna tarjeta de debito no te permetira hacer ningun tipo de movimiento sin fondo"
        }else if tempMessage.contains("que es la fecha de corte de mi tarjeta de credito"){
            return "Indica el último día que fue incluido en el registro de operaciones del período. Recuerda que para aprovechar los 50 días de crédito necesitas conocer la fecha de corte y efectuar tus comprar justo un día después de esta fecha."
        }else if tempMessage.contains("que es el pago minimo "){
            return "Es la suma requerida por el banco para mantener tu crédito vigente. Esta es la cantidad más pequeña requerida por la institución financiera para mantener tu cuenta crediticia vigente sin que el Buró de Crédito reciba un anuncio moratorio. Recuerda que si sólo realizas este pago puedes tardar mucho tiempo en liquidar tu deuda."
        }else if tempMessage.contains("cuales son los beneficios de un fondo de inversion"){
            return "Algunos beneficios de la inversión en fondos de BBVA son:No necesitas ser experto en inversiones, puedes realizar operaciones fácilmente en 5 minutos desde la App BBVA. Puedes incrementar tu inversión comprando más títulos del Fondo y diversificando tus inversiones.Todos los comprobantes de tus operaciones llegan a tu correo electrónico. Puedes disponer total o parcialmente de tu inversión. Realiza operaciones a cualquier hora todo el año. Si compras o vendes fuera del horario del Fondo, tu operación queda programada para el siguiente día hábil."
            
        }else if tempMessage.contains("que es el saldo corte y el saldo actual"){
            return "Saldo actual: es la cantidad que le debes al banco Saldo al corte: es la suma de todas las operaciones que has realizado con tu tarjeta de crédito a la fecha de corte"
            
        }
        
        else {
            return "Eso está bien."
        }
        
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
}
