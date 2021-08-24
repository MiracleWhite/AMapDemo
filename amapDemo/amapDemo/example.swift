//
//  example.swift
//  amapDemo
//
//  Created by Miracle on 2021/8/24.
//

import UIKit
import AMapFoundationKit
import AMapSearchKit
import AMapNaviKit

class example: UIViewController {
    
    let mapView = MAMapView()
    
    var carLocation: CLLocationCoordinate2D?
    
    let searchManager = AMapSearchAPI()
    
    let pointAnnotation = MAPointAnnotation()
    
    ///是否已经设置了显示两个点
    var isShow = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        mapView.frame = view.frame
        view.addSubview(mapView)
        mapView.delegate = self
        mapView.showsCompass = false
        
        //用户定位蓝点
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow //不追随head方向
        let userLocation = MAUserLocationRepresentation()
        userLocation.showsAccuracyRing = false //精度圈
        userLocation.image = UIImage.init(named: "Map_UserLocation") //自定义的图片
        mapView.update(userLocation)
        
        carLocation = CLLocationCoordinate2DMake(39.985315, 116.494063)
        //搜索地址
        searchAddress(carLocation)
        
        //打车定位的点
        pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: carLocation!.latitude, longitude: carLocation!.longitude)
        mapView.addAnnotation(pointAnnotation)
    }
    
    /// 根据坐标查询地址信息
    /// - Parameter coordinate: 坐标
    func searchAddress(_ coordinate: CLLocationCoordinate2D!) {
        
        //遵循代理
        searchManager?.delegate = self
        
        //创建search请求
        let request = AMapReGeocodeSearchRequest()
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(coordinate.latitude), longitude: CGFloat(coordinate.longitude))
        //扩展信息
        request.requireExtension = true
        //发起搜索
        searchManager?.aMapReGoecodeSearch(request)
        
    }

}

extension example: MAMapViewDelegate,AMapSearchDelegate {
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        
        if isShow  || (mapView.userLocation.coordinate.latitude == 0.0 && mapView.userLocation.coordinate.longitude == 0.0){
            return
        }
        
        //设置同时显示两个点
        mapView.showAnnotations([pointAnnotation,mapView.userLocation!],animated: true)
        isShow = true
        
    }
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if annotation.isKind(of: MAUserLocation.self) {
            return nil
        }
        
        if annotation.isKind(of: MAPointAnnotation.self) {
            
            let annotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: "CARPOINT")
            annotationView?.image = UIImage.init(named: "Map_CarLocation")
            return annotationView
        }
        return nil
    }
    
    
    /// 地址搜索结果回调
    /// - Parameters:
    ///   - request: 搜索请求
    ///   - response: 搜索结果
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        
        if response.regeocode == nil {
            return
        }
        
        //将地址信息赋值
        
    }
    
    
    /// 搜索地址失败回调
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
       
        
    }
    
}
