function [heart_rate] = Heart_rate(acf)
    [max_peaks, max_locs] = findpeaks(acf);
    [global_max, global_loc] = max(acf);
    local_max = max(max_peaks(find(max_locs > global_loc)));
    local_loc = max_locs(find(max_peaks == local_max & max_locs > global_loc));
    heart_rate = f_smapling / (local_loc - global_loc) * 60;