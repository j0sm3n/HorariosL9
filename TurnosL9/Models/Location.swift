//
//  Location.swift
//  TurnosL9
//
//  Created by Jose Antonio Mendoza on 29/10/24.
//

import Foundation
import MapKit

enum Location: String {
    case benidorm = "Benidorm"
    case intermodal = "Benidorm Intermodal"
    case camiCoves = "Cami Coves"
    case alfaz = "L'Alfàs del Pi"
    case elAlbir = "El Albir"
    case altea = "Altea"
    case garganes = "Garganes"
    case capNegret = "Cap Negret"
    case ollaAltea = "Olla Altea"
    case calp = "Calp"
    case benissa = "Benissa"
    case teulada = "Teulada"
    case gata = "Gata"
    case laXara = "La Xara"
    case pedreraVessanes = "Pedrera-Vessanes"
    case boscDeDiana = "Bosc de Diana"
    case denia = "Denia"
    case unknown
}

extension Location: Decodable {
    init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = .init(rawValue: rawValue) ?? .unknown
    }
}

extension Location {
    var monogram: String {
        switch self {
            case .benidorm: return "B"
            case .intermodal: return "BI"
            case .camiCoves: return "CC"
            case .alfaz: return "AP"
            case .elAlbir: return "AL"
            case .altea: return "AT"
            case .garganes: return "GR"
            case .capNegret: return "CN"
            case .ollaAltea: return "OA"
            case .calp: return "CL"
            case .benissa: return "BS"
            case .teulada: return "TE"
            case .gata: return "G"
            case .laXara: return "LX"
            case .pedreraVessanes: return "PV"
            case .boscDeDiana: return "BC"
            case .denia: return "D"
            case .unknown: return ""
        }
    }
}

extension Location {
    var identifier: MKMapItem.Identifier? {
        switch self {
            case .benidorm: return MKMapItem.Identifier(rawValue: "I48E9EBC50F715CBD")!
            case .intermodal: return MKMapItem.Identifier(rawValue: "I11273607EE5E9972")!
            case .camiCoves: return MKMapItem.Identifier(rawValue: "IC14C57E03FEB8556")!
            case .alfaz: return MKMapItem.Identifier(rawValue: "I3059017F19F3BFCC")!
            case .elAlbir: return MKMapItem.Identifier(rawValue: "IB55E8F8F35F8153C")!
            case .altea: return MKMapItem.Identifier(rawValue: "I9D533E978CC6031")!
            case .garganes: return MKMapItem.Identifier(rawValue: "I39734D083DEF8BC6")!
            case .capNegret: return MKMapItem.Identifier(rawValue: "IF5DC62E6C3CBF504")!
            case .ollaAltea: return MKMapItem.Identifier(rawValue: "I150F5B0EC0A21315")!
            case .calp: return MKMapItem.Identifier(rawValue: "I8378A7861E86DCA9")!
            case .benissa: return MKMapItem.Identifier(rawValue: "I8776AA921CE1C651")!
            case .teulada: return MKMapItem.Identifier(rawValue: "IA435BE44DC7A92F2")!
            case .gata: return MKMapItem.Identifier(rawValue: "I925A31DEC50FBC24")!
            case .laXara: return MKMapItem.Identifier(rawValue: "I4DC1D09E7E751663")!
            case .pedreraVessanes: return MKMapItem.Identifier(rawValue: "IC7E5710D217B6C59")!
            case .boscDeDiana: return MKMapItem.Identifier(rawValue: "I5AFC3934D2A0346C")!
            case .denia: return MKMapItem.Identifier(rawValue: "I22A10EA1D04074F3")!
            case .unknown: return nil
        }
    }
}
