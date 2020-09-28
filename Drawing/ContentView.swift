//
//  ContentView.swift
//  Drawing
//
//  Created by Derek Chan on 2020/9/27.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color : Color = .black
    @State var type : PKInkingTool.InkType = .pencil
    @State var colorPicker = false
    
    var body: some View{
        NavigationView{
            DrawingView(canvas: $canvas, isDraw: $isDraw,type: $type,color: $color)
                .navigationTitle("Drawing")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    SaveImage()
                }, label: {
                    Image(systemName: "camera.viewfinder")
                        .imageScale(.large)
                        .padding(.leading, 5)
                }),trailing: HStack(spacing: 15){
                    Button(action: {
                        isDraw = false
                    }) {
                        Image(systemName: "pencil.slash")
                            .font(.title)
                    }
                    Menu {
                        Button(action: {
                            colorPicker.toggle()
                        }) {
                            Label {
                                Text("Color")
                            } icon: {
                                Image(systemName: "eyedropper.full")
                            }
                        }
                        
                        Button(action: {
                            isDraw = true
                            type = .pencil
                        }) {
                            Label {
                                Text("Pencil")
                            } icon: {
                                Image(systemName: "pencil")
                            }
                        }
                        
                        Button(action: {
                            isDraw = true
                            type = .pen
                            
                        }) {
                            Label {
                                Text("Pen")
                            } icon: {
                                Image(systemName: "pencil.tip")
                            }
                        }
                        
                        Button(action: {
                            isDraw = true
                            type = .marker
                        }) {
                            Label {
                                Text("Marker")
                            } icon: {
                                Image(systemName: "highlighter")
                            }
                        }
                    } label: {
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            .imageScale(.large)
                    }
                })
                .sheet(isPresented: $colorPicker) {
                    ColorPicker("Pick Color", selection: $color)
                        .padding()
                }
        }
    }
    
    func SaveImage(){
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
