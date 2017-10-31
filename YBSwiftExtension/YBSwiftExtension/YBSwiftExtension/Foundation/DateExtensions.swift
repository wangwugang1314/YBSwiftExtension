//
//  DateExtensions.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

// ---------- 年 ---------- //
//  y 将年份 (0-9) 显示为不带前导零的数字
//  yy 以带前导零的两位数字格式显示年份
//  yyy 以四位数字格式显示年份
//  yyyy 以四位数字格式显示年份

// ---------- 月 ---------- //
//  M 将月份显示为不带前导零的数字（如一月表示为 1）
//  MM 将月份显示为带前导零的数字
//  MMM 将月份显示为缩写形式（例如 Jan）
//  MMMM 将月份显示为完整月份名（例如 January）
//  一月 Jan January
//  二月 Feb February
//  三月 Mar March
//  四月 Apr April
//  五月 May May
//  六月 Jun June
//  七月 Jul July
//  八月 Aug August
//  九月 Sep September
//  十月 Oct October
//  十一月 Nov November
//  十二月 Dec December

// ---------- 日 ---------- //
//  d 将日显示为不带前导零的数字（如 1）
//  dd 将日显示为带前导零的数字（如 01）

// ---------- 星期 -------- //
//  EEE 将日显示为缩写形式（例如 Sun）
//  EEEE 将日显示为全名（例如 Sunday）
//  星期一 Mon Monday
//  星期二 Tue Tuesday
//  星期三 Wed Wednesday
//  星期四 Thu Thursday
//  星期五 Fri Friday
//  星期六 Sat Saturday
//  星期天 Sun Sunday

// ---------- 小时 -------- //
//  h 使用 12 小时制将小时显示为不带前导零的数字（例如 1:15:15 PM）
//  hh 使用 12 小时制将小时显示为带前导零的数字（例如 01:15:15 PM）
//  H 使用 24 小时制将小时显示为不带前导零的数字（例如 1:15:15）
//  HH 使用 24 小时制将小时显示为带前导零的数字（例如 01:15:15）

// ---------- 分钟 -------- //
//  m 将分钟显示为不带前导零的数字（例如 12:1:15）
//  mm 将分钟显示为带前导零的数字（例如 12:01:15）

// ---------- 秒 -------- //
//  s 将秒显示为不带前导零的数字（例如 12:15:5）
//  ss 将秒显示为带前导零的数字（例如 12:15:05）
//  f 显示秒的小数部分
//  ff 将精确显示到百分之一秒
//  ffff 将精确显示到万分之一秒
//  用户定义格式中最多可使用七个 f 符号

// ---------- 上午&下午 -------- //
//  t 使用 12 小时制
//  中午之前任一小时显示大写的 A
//  中午到 11:59 PM 之间的任一小时显示大写的 P
//  tt 对于使用 12 小时制的区域设置
//  中午之前任一小时显示大写的 AM
//  中午到 11:59 PM 之间的任一小时显示大写的 PM
//  对于使用 24 小时制的区域设置，不显示任何字符

// ---------- 时区 -------- //
//  z 显示不带前导零的时区偏移量
//  zz 显示带前导零的时区偏移量（例如 -08）
//  zzz 显示完整的时区偏移量（例如 -0800）

// ---------- 纪元 -------- //
//  gg 显示时代/纪元字符串（例如 A.D.）

import Foundation


public extension Date {
	
	/// 天 名称格式
	///
	/// - threeLetters: 三个字母
	/// - oneLetter: 一个字母
	/// - full: 所有
	public enum DayNameStyle {
		case threeLetters
		case oneLetter
		case full
	}
	
	/// 月 名称格式
	///
	/// - threeLetters: 三个字母
	/// - oneLetter: 一个字母
	/// - full: 所有
	public enum MonthNameStyle {
		case threeLetters
		case oneLetter
		case full
	}
	
}


// MARK: - Properties
public extension Date {
	
	/// 获取当前日历
	public var yb_calendar: Calendar {
		return Calendar.current
	}
	
	/// 获取当前世纪
	///
	///		Date().era -> 1
	///
	public var yb_era: Int {
		return Calendar.current.component(.era, from: self)
	}
	
	/// 是否是当前季度
	///
	public var yb_quarter: Int {
		return Calendar.current.component(.quarter, from: self)
	}
	
	/// 获取本年度的第几周
	///
	///		Date().weekOfYear -> 2 // second week in the current year.
	///
	public var yb_weekOfYear: Int {
		return Calendar.current.component(.weekOfYear, from: self)
	}
	
	/// 获取本年度的第几月
	///
	///		Date().weekOfMonth -> 2 // second week in the current month.
	///
	public var yb_weekOfMonth: Int {
		return Calendar.current.component(.weekOfMonth, from: self)
	}
	
    /// 获取年
	///
	///		Date().year -> 2017
	///
	///		var someDate = Date()
	///		someDate.year = 2000 // sets someDate's year to 2000
	///
    public var yb_year: Int {
        get {
            return Calendar.current.component(.year, from: self)
        }
        set {
            if let date = Calendar.current.date(bySetting: .year, value: newValue, of: self) {
                self = date
            }
        }
    }
    
    /// 获取月
	///
	/// 	Date().month -> 1
	///
	/// 	var someDate = Date()
	/// 	someDate.year = 10 // sets someDate's month to 10.
	///
    public var yb_month: Int {
        get {
            return Calendar.current.component(.month, from: self)
        }
        set {
            if let date = Calendar.current.date(bySetting: .month, value: newValue, of: self) {
                self = date
            }
        }
    }
	
	/// 获取天
	///
	/// 	Date().day -> 12
	///
	/// 	var someDate = Date()
	/// 	someDate.day = 1 // sets someDate's day of month to 1.
	///
	public var yb_day: Int {
		get {
			return Calendar.current.component(.day, from: self)
		}
		set {
			if let date = Calendar.current.date(bySetting: .day, value: newValue, of: self) {
				self = date
			}
		}
	}
    
    /// 获取是当前周的第几天
	///
	/// 	Date().weekOfMonth -> 5 // fifth day in the current week.
	///
    public var yb_weekday: Int {
        get {
            return Calendar.current.component(.weekday, from: self)
        }
        set {
            if let date = Calendar.current.date(bySetting: .weekday, value: newValue, of: self) {
                self = date
            }
        }
    }
	
	/// 或取小时yb_
	///
	/// 	Date().hour -> 17 // 5 pm
	///
	/// 	var someDate = Date()
	/// 	someDate.day = 13 // sets someDate's hour to 1 pm.
	///
	public var yb_hour: Int {
		get {
			return Calendar.current.component(.hour, from: self)
		}
		set {
			if let date = Calendar.current.date(bySetting: .hour, value: newValue, of: self) {
				self = date
			}
		}
	}
	
	/// 获取分钟
	///
	/// 	Date().minute -> 39
	///
	/// 	var someDate = Date()
	/// 	someDate.minute = 10 // sets someDate's minutes to 10.
	///
	public var yb_minute: Int {
		get {
			return Calendar.current.component(.minute, from: self)
		}
		set {
			if let date = Calendar.current.date(bySetting: .minute, value: newValue, of: self) {
				self = date
			}
		}
	}
	
	/// 获取秒
	///
	/// 	Date().second -> 55
	///
	/// 	var someDate = Date()
	/// 	someDate. second = 15 // sets someDate's seconds to 15.
	///
	public var yb_second: Int {
		get {
			return Calendar.current.component(.second, from: self)
		}
		set {
			if let date = Calendar.current.date(bySetting: .second, value: newValue, of: self) {
				self = date
			}
		}
	}
	
	/// 纳秒
	///
	/// 	Date().nanosecond -> 981379985
	///
	public var yb_nanosecond: Int {
		get {
			return Calendar.current.component(.nanosecond, from: self)
		}
		set {
			if let date = Calendar.current.date(bySetting: .nanosecond, value: newValue, of: self) {
				self = date
			}
		}
	}
	
	/// 毫秒
	///
	public var yb_millisecond: Int {
		get {
			return Calendar.current.component(.nanosecond, from: self) / 1000000
		}
		set {
			let ns = newValue * 1000000
			if let date = Calendar.current.date(bySetting: .nanosecond, value: ns, of: self) {
				self = date
			}
		}
	}
	
	/// 检查如期是否在将来
	///
	/// 	Date(timeInterval: 100, since: Date()).isInFuture -> true
	///
	public var yb_isInFuture: Bool {
		return self > Date()
	}
	
	/// 检查日期是否已经过去
	///
	/// 	Date(timeInterval: -100, since: Date()).isInPast -> true
	///
	public var yb_isInPast: Bool {
		return self < Date()
	}
	
	/// 检查日期是否是今天
	///
	/// 	Date().isInToday -> true
	///
	public var yb_isInToday: Bool {
		return Calendar.current.isDateInToday(self)
	}
	
	/// 检查日期是否是昨天
	///
	/// 	Date().isInYesterday -> false
	///
	public var yb_isInYesterday: Bool {
		return Calendar.current.isDateInYesterday(self)
	}
	
	/// 检查日期上是否是明天
	///
	/// 	Date().isInTomorrow -> false
	///
	public var yb_isInTomorrow: Bool {
		return Calendar.current.isDateInTomorrow(self)
	}
	
	/// 检查按日期是否在周末
	///
	public var yb_isInWeekend: Bool {
		return Calendar.current.isDateInWeekend(self)
	}
    
    /// 检查日期是否在工作日内
	///
    public var yb_isInWeekday: Bool {
        return !Calendar.current.isDateInWeekend(self)
    }
	
	/// 转化为 iso8601 字符串格式 (yyyy-MM-dd'T'HH:mm:ss.SSS)
	///
	/// 	Date().iso8601String -> "2017-01-12T14:51:29.574Z"
	///
	public var yb_iso8601String: String {
		// https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
		let dateFormatter = DateFormatter()
		dateFormatter.locale = Locale(identifier: "en_US_POSIX")
		dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
		
		return dateFormatter.string(from: self).appending("Z")
	}
	
	/// 设置成最近的五分钟
	///
	/// 	var date = Date() // "5:54 PM"
	/// 	date.minute = 32 // "5:32 PM"
	/// 	date.nearestFiveMinutes // "5:30 PM"
	///
	/// 	date.minute = 44 // "5:44 PM"
	/// 	date.nearestFiveMinutes // "5:45 PM"
	///
	public var yb_nearestFiveMinutes: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		let min = components.minute!
		components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
		components.second = 0
		return Calendar.current.date(from: components)!
	}
	
	/// 设置成最近的十分钟
	///
	/// 	var date = Date() // "5:57 PM"
	/// 	date.minute = 34 // "5:34 PM"
	/// 	date.nearestTenMinutes // "5:30 PM"
	///
	/// 	date.minute = 48 // "5:48 PM"
	/// 	date.nearestTenMinutes // "5:50 PM"
	///
	public var yb_nearestTenMinutes: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		let min = components.minute!
		components.minute? = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
		components.second = 0
		return Calendar.current.date(from: components)!
	}
	
	/// 设置成最近的一刻
	///
	/// 	var date = Date() // "5:57 PM"
	/// 	date.minute = 34 // "5:34 PM"
	/// 	date.nearestQuarterHour // "5:30 PM"
	///
	/// 	date.minute = 40 // "5:40 PM"
	/// 	date.nearestQuarterHour // "5:45 PM"
	///
	public var yb_nearestQuarterHour: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		let min = components.minute!
		components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
		components.second = 0
		return Calendar.current.date(from: components)!
	}
	
	/// 设置成最近的半小时
	///
	/// 	var date = Date() // "6:07 PM"
	/// 	date.minute = 41 // "6:41 PM"
	/// 	date.nearestHalfHour // "6:30 PM"
	///
	/// 	date.minute = 51 // "6:51 PM"
	/// 	date.nearestHalfHour // "7:00 PM"
	///
	public var yb_nearestHalfHour: Date {
		var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
		let min = components.minute!
		components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
		components.second = 0
		return Calendar.current.date(from: components)!
	}
	
	/// 设置成最近的小时
	///
	/// 	var date = Date() // "6:17 PM"
	/// 	date.nearestHour // "6:00 PM"
	///
	/// 	date.minute = 36 // "6:36 PM"
	/// 	date.nearestHour // "7:00 PM"
	///
	public var yb_nearestHour: Date {
		if yb_minute >= 30 {
			return yb_beginning(of: .hour)!.yb_adding(.hour, value: 1)
		}
		return yb_beginning(of: .hour)!
	}
	
	/// 获取时区
	///
	///		Date().timeZone -> Europe/Istanbul (current)
	///
	public var yb_timeZone: TimeZone {
		return Calendar.current.timeZone
	}
	
	/// 获取时间戳的日期
	///
	///		Date().unixTimestamp -> 1484233862.826291
	///
	public var yb_unixTimestamp: Double {
		return timeIntervalSince1970
	}
	
}


// MARK: - 方法
public extension Date {
	
	/// 添加指定的时间(返回新的时间)
	///
	/// 	let date = Date() // "Jan 12, 2017, 7:07 PM"
	/// 	let date2 = date.adding(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
	/// 	let date3 = date.adding(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
	/// 	let date4 = date.adding(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
	/// 	let date5 = date.adding(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
	///
	/// - Parameters:
	///   - component: component type.
	///   - value: multiples of components to add.
	/// - Returns: original date + multiples of component added.
	public func yb_adding(_ component: Calendar.Component, value: Int) -> Date {
		return Calendar.current.date(byAdding: component, value: value, to: self)!
	}
	
	/// 添加指定的时间(在当前时间上添加)
	///
	/// 	var date = Date() // "Jan 12, 2017, 7:07 PM"
	/// 	date.add(.minute, value: -10) // "Jan 12, 2017, 6:57 PM"
	/// 	date.add(.day, value: 4) // "Jan 16, 2017, 7:07 PM"
	/// 	date.add(.month, value: 2) // "Mar 12, 2017, 7:07 PM"
	/// 	date.add(.year, value: 13) // "Jan 12, 2030, 7:07 PM"
	///
	/// - Parameters:
	///   - component: component type.
	///   - value: multiples of compnenet to add.
	public mutating func yb_add(_ component: Calendar.Component, value: Int) {
		self = yb_adding(component, value: value)
	}
	
	/// 修改指定的值
	///
	/// 	let date = Date() // "Jan 12, 2017, 7:07 PM"
	/// 	let date2 = date.changing(.minute, value: 10) // "Jan 12, 2017, 7:10 PM"
	/// 	let date3 = date.changing(.day, value: 4) // "Jan 4, 2017, 7:07 PM"
	/// 	let date4 = date.changing(.month, value: 2) // "Feb 12, 2017, 7:07 PM"
	/// 	let date5 = date.changing(.year, value: 2000) // "Jan 12, 2000, 7:07 PM"
	///
	/// - Parameters:
	///   - component: component type.
	///   - value: new value of compnenet to change.
	/// - Returns: original date after changing given component to given value.
	public func yb_changing(_ component: Calendar.Component, value: Int) -> Date? {
		return Calendar.current.date(bySetting: component, value: value, of: self)
	}
	
	/// 获取日期组件开始部分的数值
	///
	/// 	let date = Date() // "Jan 12, 2017, 7:14 PM"
	/// 	let date2 = date.beginning(of: .hour) // "Jan 12, 2017, 7:00 PM"
	/// 	let date3 = date.beginning(of: .month) // "Jan 1, 2017, 12:00 AM"
	/// 	let date4 = date.beginning(of: .year) // "Jan 1, 2017, 12:00 AM"
	///
	/// - Parameter component: calendar component to get date at the beginning of.
	/// - Returns: date at the beginning of calendar component (if applicable).
	public func yb_beginning(of component: Calendar.Component) -> Date? {
		switch component {
		case .second:
			return Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self))
			
		case .minute:
			return Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self))
			
		case .hour:
			return Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month, .day, .hour], from: self))
			
		case .day:
			return Calendar.current.startOfDay(for: self)
			
		case .weekOfYear, .weekOfMonth:
			return Calendar.current.date(from:
				Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
			
		case .month:
			return Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month], from: self))
			
		case .year:
			return Calendar.current.date(from:
				Calendar.current.dateComponents([.year], from: self))
			
		default:
			return nil
		}
	}
	
	/// 获取日期的末尾日期
	///
	/// 	let date = Date() // "Jan 12, 2017, 7:27 PM"
	/// 	let date2 = date.end(of: .day) // "Jan 12, 2017, 11:59 PM"
	/// 	let date3 = date.end(of: .month) // "Jan 31, 2017, 11:59 PM"
	/// 	let date4 = date.end(of: .year) // "Dec 31, 2017, 11:59 PM"
	///
	/// - Parameter component: calendar component to get date at the end of.
	/// - Returns: date at the end of calendar component (if applicable).
	public func yb_end(of component: Calendar.Component) -> Date? {
		switch component {
		case .second:
			var date = yb_adding(.second, value: 1)
			date = Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
			date.yb_add(.second, value: -1)
			return date
			
		case .minute:
			var date = yb_adding(.minute, value: 1)
			let after = Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
			date = after.yb_adding(.second, value: -1)
			return date
			
		case .hour:
			var date = yb_adding(.hour, value: 1)
			let after = Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month, .day, .hour], from: date))!
			date = after.yb_adding(.second, value: -1)
			return date
			
		case .day:
			var date = yb_adding(.day, value: 1)
			date = Calendar.current.startOfDay(for: date)
			date.yb_add(.second, value: -1)
			return date
			
		case .weekOfYear, .weekOfMonth:
			var date = self
			let beginningOfWeek = Calendar.current.date(from:
				Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
			date = beginningOfWeek.yb_adding(.day, value: 7).yb_adding(.second, value: -1)
			return date
			
		case .month:
			var date = yb_adding(.month, value: 1)
			let after = Calendar.current.date(from:
				Calendar.current.dateComponents([.year, .month], from: date))!
			date = after.yb_adding(.second, value: -1)
			return date
			
		case .year:
			var date = yb_adding(.year, value: 1)
			let after = Calendar.current.date(from:
				Calendar.current.dateComponents([.year], from: date))!
			date = after.yb_adding(.second, value: -1)
			return date
			
		default:
			return nil
		}
	}
	
	/// 根据日子格式设置获取日期字符串
	///
	/// 	Date().dateString(ofStyle: .short) -> "1/12/17"
	/// 	Date().dateString(ofStyle: .medium) -> "Jan 12, 2017"
	/// 	Date().dateString(ofStyle: .long) -> "January 12, 2017"
	/// 	Date().dateString(ofStyle: .full) -> "Thursday, January 12, 2017"
	///
	/// - Parameter style: DateFormatter style (default is .medium).
	/// - Returns: date string.
	public func yb_dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = .none
		dateFormatter.dateStyle = style
		return dateFormatter.string(from: self)
	}
	
	/// 根据指定格式设置日期时间格式
	///
	/// 	Date().dateTimeString(ofStyle: .short) -> "1/12/17, 7:32 PM"
	/// 	Date().dateTimeString(ofStyle: .medium) -> "Jan 12, 2017, 7:32:00 PM"
	/// 	Date().dateTimeString(ofStyle: .long) -> "January 12, 2017 at 7:32:00 PM GMT+3"
	/// 	Date().dateTimeString(ofStyle: .full) -> "Thursday, January 12, 2017 at 7:32:00 PM GMT+03:00"
	///
	/// - Parameter style: DateFormatter style (default is .medium).
	/// - Returns: date and time string.
	public func yb_dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = style
		dateFormatter.dateStyle = style
		return dateFormatter.string(from: self)
	}
	
	/// 检查日期是否在当前组件类型中
	///
	/// 	Date().isInCurrent(.day) -> true
	/// 	Date().isInCurrent(.year) -> true
	///
	/// - Parameter component: calendar component to check.
	/// - Returns: true if date is in current given calendar component.
	public func yb_isInCurrent(_ component: Calendar.Component) -> Bool {
		return yb_calendar.isDate(self, equalTo: Date(), toGranularity: component)
	}
	
	/// 获取事件字符串
	///
	/// 	Date().timeString(ofStyle: .short) -> "7:37 PM"
	/// 	Date().timeString(ofStyle: .medium) -> "7:37:02 PM"
	/// 	Date().timeString(ofStyle: .long) -> "7:37:02 PM GMT+3"
	/// 	Date().timeString(ofStyle: .full) -> "7:37:02 PM GMT+03:00"
	///
	/// - Parameter style: DateFormatter style (default is .medium).
	/// - Returns: time string.
	public func yb_timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = style
		dateFormatter.dateStyle = .none
		return dateFormatter.string(from: self)
	}
	
	/// 获取每周天的名称
	///
	/// 	Date().dayName(ofStyle: .oneLetter) -> "T"
	/// 	Date().dayName(ofStyle: .threeLetters) -> "Thu"
	/// 	Date().dayName(ofStyle: .full) -> "Thursday"
	///
	/// - Parameter Style: style of day name (default is DayNameStyle.full).
	/// - Returns: day name string (example: W, Wed, Wednesday).
	public func yb_dayName(ofStyle style: DayNameStyle = .full) -> String {
		// http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
		let dateFormatter = DateFormatter()
		var format: String {
			switch style {
			case .oneLetter:
				return "EEEEE"
			case .threeLetters:
				return "EEE"
			case .full:
				return "EEEE"
			}
		}
		dateFormatter.setLocalizedDateFormatFromTemplate(format)
		return dateFormatter.string(from: self)
	}
	
	/// 获取月的名称
	///
	/// 	Date().monthName(ofStyle: .oneLetter) -> "J"
	/// 	Date().monthName(ofStyle: .threeLetters) -> "Jan"
	/// 	Date().monthName(ofStyle: .full) -> "January"
	///
	/// - Parameter Style: style of month name (default is MonthNameStyle.full).
	/// - Returns: month name string (example: D, Dec, December).
	public func yb_monthName(ofStyle style: MonthNameStyle = .full) -> String {
		// http://www.codingexplorer.com/swiftly-getting-human-readable-date-nsdateformatter/
		let dateFormatter = DateFormatter()
		var format: String {
			switch style {
			case .oneLetter:
				return "MMMMM"
			case .threeLetters:
				return "MMM"
			case .full:
				return "MMMM"
			}
		}
		dateFormatter.setLocalizedDateFormatFromTemplate(format)
		return dateFormatter.string(from: self)
	}
    
    /// 根据格式化字符串获取时间字符串
    ///
    /// - Parameter dateFormat: 字符串格式
    /// - Returns: 返回创建好的字符串
    func yb_normalString(dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        return formatter.string(from: self)
    }
    
    /// 根据指定分隔符获取字符串
    ///
    /// - Parameters:
    ///   - dateInterval: 日期分隔符
    ///   - timeInterval: 时间分隔符
    /// - Returns: 返回的字符串
    func yb_normalString(dateInterval: String = "/", timeInterval: String = ":", isSecond: Bool = false) -> String {
        let formatter = DateFormatter()
        var formatterStr = "yyyy" + dateInterval + "MM" + dateInterval + "dd HH" + timeInterval + "mm"
        if isSecond {
            formatterStr += timeInterval + "ss"
        }
        formatter.dateFormat =  formatterStr
        return formatter.string(from: self)
    }
    
    /// 根据指定分隔符获取日期字符串
    ///
    /// - Parameter dateInterval: 日期字符串间隔
    /// - Returns: 返回字符串
    func yb_normalDateString(dateInterval: String = "/", isDay: Bool = false) -> String {
        let formatter = DateFormatter()
        var formatterStr = "yyyy" + dateInterval + "MM"
        if isDay {
            formatterStr += dateInterval + "dd"
        }
        formatter.dateFormat = formatterStr
        return formatter.string(from: self)
    }
    
    /// 根据指定分隔符获取时间字符串
    ///
    /// - Parameter timeInterval: 时间间隔
    /// - Parameter isSecond: 是否需要秒
    /// - Returns: 返回字符串
    func yb_normalTimeString(timeInterval: String = ":", isSecond: Bool = false) -> String {
        let formatter = DateFormatter()
        var formatterStr = "HH" + timeInterval + "mm"
        if isSecond {
         formatterStr += timeInterval + "ss"
        }
        formatter.dateFormat = formatterStr
        return formatter.string(from: self)
    }
}

public extension String {
    
    /// 根据格式化字符串和时间字符串获取时间
    func yb_normalDate(formatStr: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = formatStr
        return formatter.date(from: self)
    }
}


// MARK: - 构造方法
public extension Date {
	
	/// 根据指定数据设置时间
	///
	/// 	let date = Date(year: 2010, month: 1, day: 12) // "Jan 12, 2010, 7:45 PM"
	///
	/// - Parameters:
	///   - calendar: Calendar (default is current).
	///   - timeZone: TimeZone (default is current).
	///   - era: Era (default is current era).
	///   - year: Year (default is current year).
	///   - month: Month (default is current month).
	///   - day: Day (default is today).
	///   - hour: Hour (default is current hour).
	///   - minute: Minute (default is current minute).
	///   - second: Second (default is current second).
	///   - nanosecond: Nanosecond (default is current nanosecond).
	public init?(
		calendar: Calendar? = Calendar.current,
		timeZone: TimeZone? = TimeZone.current,
		era: Int? = Date().yb_era,
		year: Int? = Date().yb_year,
		month: Int? = Date().yb_month,
		day: Int? = Date().yb_day,
		hour: Int? = Date().yb_hour,
		minute: Int? = Date().yb_minute,
		second: Int? = Date().yb_second,
		nanosecond: Int? = Date().yb_nanosecond) {
		
		var components = DateComponents()
		components.calendar = calendar
		components.timeZone = timeZone
		components.era = era
		components.year = year
		components.month = month
		components.day = day
		components.hour = hour
		components.minute = minute
		components.second = second
		components.nanosecond = nanosecond
		
		if let date = calendar?.date(from: components) {
			self = date
		} else {
			return nil
		}
	}
	
	/// 根据时间字符串设置时间
	///
	/// 	let date = Date(iso8601String: "2017-01-12T16:48:00.959Z") // "Jan 12, 2017, 7:48 PM"
	///
	/// - Parameter iso8601String: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
	public init?(iso8601String: String) {
		// https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
		let dateFormatter = DateFormatter()
		dateFormatter.locale = .posix
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		if let date = dateFormatter.date(from: iso8601String) {
			self = date
		} else {
			return nil
		}
	}
	
	/// 从时间错设置时间
	///
	/// 	let date = Date(unixTimestamp: 1484239783.922743) // "Jan 12, 2017, 7:49 PM"
	///
	/// - Parameter unixTimestamp: UNIX timestamp.
	public init(unixTimestamp: Double) {
		self.init(timeIntervalSince1970: unixTimestamp)
	}
	
}

// MARK: - 属性
public extension Locale {
    
    /// 获取事件地区字符串
    public static var posix: Locale {
        return Locale(identifier: "en_US_POSIX")
    }
    
}

