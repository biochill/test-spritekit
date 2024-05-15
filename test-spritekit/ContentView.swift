//
//  ContentView.swift
//  test-spritekit
//
//  Created by Sven Thoennissen on 15.05.24.
//

import SwiftUI
import SpriteKit
import SceneKit

struct ContentView: View {
	
	var spriteScene = SKScene(fileNamed: "SpriteKitScene")!
	var scnScene = SCNScene(named: "SceneKitScene.scn")!
	
    var body: some View {
        VStack {
			SpriteView(scene: spriteScene)
				.frame(width: 700, height: 500)
			HStack {
				Button("Breakpoint") {
					debugStuff(scene: spriteScene)
				}
				.buttonStyle(.bordered)
				Text("Above: SpriteKit scene, Below: SceneKit scene")
			}
			SceneView(scene: scnScene)
//			MySceneView(scene: scnScene)
				.frame(width: 700, height: 500)
        }
        .padding()
		.onAppear {
			fillScene()
		}
    }
	
	func debugStuff(scene: SKScene) {
		print("break")
	}
	
	func fillScene() {
		// Set sRGB red color
		if let node = spriteScene.childNode(withName: "red srgb") as? SKShapeNode {
			node.fillColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
		}

		// Set DisplayP3 red color -- this will result in a different color!
		if let node = spriteScene.childNode(withName: "red dp3") as? SKShapeNode {
			node.fillColor = UIColor(displayP3Red: 1, green: 0, blue: 0, alpha: 1)
		}

		// Add SceneKit nodes
		let node3d_1 = make3DNode(camPos: SCNVector3(x: -5, y: -2, z: 14))
		node3d_1.name = "3d_1"
		node3d_1.position = CGPoint(x: 150, y: 110)
		spriteScene.addChild(node3d_1)

		let node3d_2 = make3DNode(camPos: SCNVector3(x: 5, y: 2, z: 14))
		node3d_2.name = "3d_2"
		node3d_2.position = CGPoint(x: 150, y: -110)
		spriteScene.addChild(node3d_2)

		// Add boxes to show the frames
		let frame_1 = SKShapeNode(rectOf: node3d_1.viewportSize)
		frame_1.position = node3d_1.position
		frame_1.fillColor = .clear
		spriteScene.addChild(frame_1)

		let frame_2 = SKShapeNode(rectOf: node3d_2.viewportSize)
		frame_2.position = node3d_2.position
		frame_2.fillColor = .clear
		spriteScene.addChild(frame_2)
	}
	
	func make3DNode(camPos: SCNVector3) -> SK3DNode {
		// Add SceneKit scene in 3D node
		let node3d = SK3DNode(viewportSize: CGSize(width: 300, height: 200))
		node3d.scnScene = scnScene
		node3d.autoenablesDefaultLighting = false
		
		let camera = SCNCamera()
		let cameraNode = SCNNode()
		cameraNode.camera = camera
		if let lookAtTarget = scnScene.rootNode.childNode(withName: "red_texture", recursively: false) {
			let constraint = SCNLookAtConstraint(target: lookAtTarget)
			// why does this not work?
			cameraNode.constraints = [constraint]
		}
		cameraNode.position = camPos
		node3d.pointOfView = cameraNode

		return node3d
	}
}

#Preview {
    ContentView()
}
