//
//  MarketData.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 23/02/2022.
//

import Foundation

struct GlobalData: Decodable {
  let data: MarketData?
}

struct MarketData: Decodable {
  let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
  let marketCapChangePercentage24HUsd: Double

  enum CodingKeys: String, CodingKey {
    case totalMarketCap = "total_market_cap"
    case totalVolume = "total_volume"
    case marketCapPercentage = "market_cap_percentage"
    case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
  }

  var marketCap: String {
    if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
      return "$" + item.value.formattedWithAbbreviations()
    }
    return ""
  }

  var volume: String {
    if let item = totalVolume.first(where: { $0.key == "usd" }) {
      return "$" + item.value.formattedWithAbbreviations()
    }
    return ""
  }

  var btcDominance: String {
    if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
      return item.value.asPercentString()
    }
    return ""
  }
}

/* COIN GECKO API

 URL:
 https://api.coingecko.com/api/v3/global

 RESPONSE:
 {
 "data": {
 "active_cryptocurrencies": 12798,
 "upcoming_icos": 0,
 "ongoing_icos": 49,
 "ended_icos": 3376,
 "markets": 748,
 "total_market_cap": {
 "btc": 47495836.23420651,
 "eth": 678470807.6255778,
 "ltc": 16759851689.522778,
 "bch": 6122038314.459296,
 "bnb": 4858889442.347372,
 "eos": 833993636132.9851,
 "xrp": 2530478755213.6665,
 "xlm": 9666285343293.031,
 "link": 128664646368.22093,
 "dot": 107777058015.50264,
 "yfi": 88300920.1068435,
 "usd": 1832684066092.9465,
 "aed": 6731448574759.389,
 "ars": 196679772348242.94,
 "aud": 2523050655737.9614,
 "bdt": 157542805949512.3,
 "bhd": 690965877334.6246,
 "bmd": 1832684066092.9465,
 "brl": 9180464292279.371,
 "cad": 2329649338927.239,
 "chf": 1681304362233.6692,
 "clp": 1440141465976498.8,
 "cny": 11571567193310.861,
 "czk": 39759164471853.43,
 "dkk": 12028257401108.701,
 "eur": 1616892848046.7656,
 "gbp": 1349683845842.2832,
 "hkd": 14303045342517.422,
 "huf": 580357379076813.6,
 "idr": 26294343004065230,
 "ils": 5905602648212.542,
 "inr": 136641243938285.4,
 "jpy": 210956902933280.25,
 "krw": 2183238321971800.5,
 "kwd": 554282467001.3467,
 "lkr": 371080942364362.06,
 "mmk": 3258460333079509,
 "mxn": 37062787720564.7,
 "myr": 7670699158632.037,
 "ngn": 762323264132020.6,
 "nok": 16219235658081.898,
 "nzd": 2698262583192.71,
 "php": 93654735654830.84,
 "pkr": 323435905130361.1,
 "pln": 7377277276230.193,
 "rub": 147637179727909.03,
 "sar": 6875770612280.138,
 "sek": 17093163883786.785,
 "sgd": 2464492734458.1567,
 "thb": 59159041653480.5,
 "try": 25390591510552.816,
 "twd": 51094315420638.36,
 "uah": 53077596634494.055,
 "vef": 183506655537.8868,
 "vnd": 41837326560311820,
 "zar": 27552993766976.562,
 "xdr": 1305752576093.9668,
 "xag": 75236482545.36844,
 "xau": 961224465.8250899,
 "bits": 47495836234206.516,
 "sats": 4749583623420651
 },
 "total_volume": {
 "btc": 2022733.5076928912,
 "eth": 28894440.973908693,
 "ltc": 713761800.7017157,
 "bch": 260722897.32880008,
 "bnb": 206928422.8778976,
 "eos": 35517784436.73094,
 "xrp": 107767008110.68881,
 "xlm": 411663859593.6103,
 "link": 5479518039.878656,
 "dot": 4589965855.8177185,
 "yfi": 3760523.9537100913,
 "usd": 78049609469.37178,
 "aed": 286676215581.00244,
 "ars": 8376118779180.12,
 "aud": 107450663207.65573,
 "bdt": 6709369447011.303,
 "bhd": 29426575960.580322,
 "bmd": 78049609469.37178,
 "brl": 390973908714.923,
 "cad": 99214165969.9624,
 "chf": 71602711727.20168,
 "clp": 61332163617127.06,
 "cny": 492805234189.6133,
 "czk": 1693247252633.2864,
 "dkk": 512254572472.50525,
 "eur": 68859580152.7911,
 "gbp": 57479790992.93781,
 "hkd": 609132323383.001,
 "huf": 24716025870285.594,
 "idr": 1119812869381337.6,
 "ils": 251505422512.30557,
 "inr": 5819222158420.547,
 "jpy": 8984147455328.86,
 "krw": 92978872660653.97,
 "kwd": 23605558036.745113,
 "lkr": 15803445432255.992,
 "mmk": 138769993788660.23,
 "mxn": 1578415047610.0637,
 "myr": 326676640434.056,
 "ngn": 32465515554879.83,
 "nok": 690738263307.8448,
 "nzd": 114912518071.3655,
 "php": 3988530089858.9673,
 "pkr": 13774357812590.482,
 "pln": 314180507709.9608,
 "rub": 6287512634672.708,
 "sar": 292822544277.1058,
 "sek": 727956765930.5812,
 "sgd": 104956822085.89024,
 "thb": 2519441393671.329,
 "try": 1081324265463.7063,
 "twd": 2175984087201.353,
 "uah": 2260447267229.6387,
 "vef": 7815107396.1682005,
 "vnd": 1781751181062162.2,
 "zar": 1173415780172.7136,
 "xdr": 55608863804.3474,
 "xag": 3204140958.694514,
 "xau": 40936239.670590825,
 "bits": 2022733507692.891,
 "sats": 202273350769289.12
 },
 "market_cap_percentage": {
 "btc": 39.93267095346018,
 "eth": 17.654306086950797,
 "usdt": 4.308611126679033,
 "bnb": 3.4644861426619205,
 "usdc": 2.869130640054922,
 "xrp": 1.8987701321759407,
 "ada": 1.6136118498903438,
 "sol": 1.5838677371570167,
 "luna": 1.2545272702059207,
 "avax": 1.0743475233524664
 },
 "market_cap_change_percentage_24h_usd": 2.4724435535600544,
 "updated_at": 1645629027
 }
 }
 */
