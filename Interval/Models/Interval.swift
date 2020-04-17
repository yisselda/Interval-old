struct Interval {
    var start: Int = 0
    var end: Int = 0
    
    func fromHoursMinutesSeconds(hours: Int, minutes: Int, seconds: Int) -> Int {
        return hours * 3600 + minutes * 60 + seconds
    }
    
    func fromHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
