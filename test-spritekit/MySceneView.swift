//
//  MySceneView.swift
//  test-spritekit
//
//  Created by Sven Thoennissen on 15.05.24.
//

import SwiftUI
import SceneKit

class MySCNView: SCNView, SCNSceneRendererDelegate {
	func renderer(_ renderer: any SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval) {
		print("didRender @\(time)")
	}
}

struct MySceneView: UIViewRepresentable {
	var scene: SCNScene
//	var visibleSize: CGSize
	
	func makeUIView(context: Context) -> SCNView {
		//		SLog.print("DiceView.makeUIView size=\(visibleSize)")
		
		let scnView = context.coordinator
		scnView.scene = scene
		scnView.delegate = scnView
//		scnView.isMultipleTouchEnabled = true
		
		//		let recog = UITapGestureRecognizer(target: scene, action: #selector(DiceScene.scenePressed(_:)))
		//		scnView.addGestureRecognizer(recog)
		
		//		scene.diceDelegate = scnView
//		scene.visibleSize = visibleSize
		//		scene.updateBoundaries(size: visibleSize)
		//		scnView.updateBoundaries(visibleSize: visibleSize)
		
		return scnView
	}
	
	func updateUIView(_ uiView: UIViewType, context: Context) {
		print("MySceneView.updateUIView")
		//		let scnView = context.coordinator
		//		scnView.updateBoundaries(visibleSize: visibleSize)
//		scene.visibleSize = visibleSize
	}
	
	func makeCoordinator() -> MySCNView {
		MySCNView()
	}
}
