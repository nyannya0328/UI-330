//
//  Home.swift
//  UI-330 (iOS)
//
//  Created by nyannyan0328 on 2021/10/15.
//

import SwiftUI
import PencilKit

struct Home: View {
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color : Color = .black
    @State var type : PKInkingTool.InkType = .pencil
    @State var colorPicker : Bool = false
    
    
    init() {
        
       let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = UIColor.init(red: 41/255, green: 199 / 255, blue: 50 / 255, alpha: 1)
        UINavigationBar.appearance().standardAppearance = appearence
        UINavigationBar.appearance().scrollEdgeAppearance = appearence
       
    }
  
    var body: some View {
        NavigationView{
            
            Canvas(canvas: $canvas, isDraw: $isDraw, tyoe: $type, color: $color)
                .navigationBarTitle("Canvas")
               .navigationBarTitleDisplayMode(.inline)
               
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        Button {
                            
                            
                            SaveImage()
                            
                        } label: {
                            
                            Image(systemName: "square.and.arrow.up.fill")
                        }

                        
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Button {
                            
                          
                            
                            isDraw = false
                            
                        } label: {
                            
                            Image(systemName: "pencil.slash")
                               
                        }

                        
                    }
                    
                    
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Menu {
                            
                            Button {
                                
                                colorPicker.toggle()
                                
                            } label: {
                                ColorPicker(selection: $color){
                                    
                                    
                                    Label {
                                        Text("Color")
                                        
                                    } icon: {
                                        Image(systemName: "eyedropper.full")
                                    }

                                }
                                
                            }

                            
                            Button {
                                isDraw = true
                                
                                type = .pencil
                            } label: {
                                
                                Label {
                                    
                                    Text("Pencil")
                                    
                                } icon: {
                                    
                                    Image(systemName: "pencil")
                                    
                                    
                                }

                            }
                            Button {
                                isDraw = true
                                type = .pen
                                
                            } label: {
                                
                                Label {
                                    
                                    Text("Pen")
                                    
                                } icon: {
                                    
                                    Image(systemName: "pencil.tip")
                                    
                                    
                                }

                            }
                            Button {
                                isDraw = true
                                type = .marker
                                
                            } label: {
                                
                                Label {
                                    
                                    Text("Marker")
                                    
                                } icon: {
                                    
                                    Image(systemName: "highlighter")
                                    
                                    
                                }

                            }
                  
                        } label: {
                            
                            Image("m")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.black)
                                .frame(width: 25, height: 25)
                                .padding(.trailing,2)
                        }
                        
                    }
                    
                }
                
                .sheet(isPresented: $colorPicker) {
                    
                    
                    
                ColorPicker("Picker Color", selection: $color)
                        .padding()
                }
          }

        
    }
    func SaveImage(){
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
        //0.1で拡大される
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        
    }
}

struct Canvas : UIViewRepresentable{
    @Binding var canvas : PKCanvasView
    
    @Binding var isDraw : Bool
    @Binding var tyoe : PKInkingTool.InkType
    @Binding var color : Color
    
   // let ink = PKInkingTool(.pencil,color: .black)
    
    var ink : PKInkingTool{
        
        PKInkingTool(tyoe, color: UIColor(color))
    }
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) ->PKCanvasView {
        
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDraw ? ink : eraser
        return canvas
        
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        uiView.tool = isDraw ? ink : eraser
        
    }
}
