document.addEventListener("DOMContentLoaded", function () {
    loadProvinces();
});

let locationData = {}; // Biến chứa dữ liệu địa phương

// Load danh sách tỉnh/thành phố
async function loadProvinces(selectedProvince = "") {
    try {
        const response = await fetch("js/tree.json");
        locationData = await response.json();

        const provinceSelect = document.getElementById("province");
        provinceSelect.innerHTML = '<option value="" hidden>Chọn tỉnh/thành phố</option>';

        for (const province of Object.values(locationData)) {
            const option = document.createElement("option");
            option.value = province.name_with_type;
            option.textContent = province.name_with_type;
            provinceSelect.appendChild(option);
        }

        if (selectedProvince) {
            provinceSelect.value = selectedProvince;
        }
    } catch (error) {
        console.error("Lỗi tải dữ liệu:", error);
}
}






// Load danh sách quận/huyện theo tỉnh đã chọn
async function loadDistricts(selectedProvince = "", selectedDistrict = "") {
    const provinceName = selectedProvince || document.getElementById("province").value;
    const districtSelect = document.getElementById("district");
    districtSelect.innerHTML = '<option value="" hidden>Chọn quận/huyện</option>';

    const province = Object.values(locationData).find(p => p.name_with_type === provinceName);
    if (!province || !province["quan-huyen"])
        return;

    for (const district of Object.values(province["quan-huyen"])) {
        const option = document.createElement("option");
        option.value = district.name_with_type;
        option.textContent = district.name_with_type;
        districtSelect.appendChild(option);
    }

    if (selectedDistrict) {
        districtSelect.value = selectedDistrict;
}
}





// Load danh sách xã/phường theo quận/huyện đã chọn
async function loadWards(selectedProvince = "", selectedDistrict = "", selectedWard = "") {
    const provinceName = selectedProvince || document.getElementById("province").value;
    const districtName = selectedDistrict || document.getElementById("district").value;
    const wardSelect = document.getElementById("ward");
    wardSelect.innerHTML = '<option value="" hidden>Chọn xã/phường</option>';

    const province = Object.values(locationData).find(p => p.name_with_type === provinceName);
    if (!province)
        return;

    const district = Object.values(province["quan-huyen"]).find(d => d.name_with_type === districtName);
    if (!district || !district["xa-phuong"])
        return;

    for (const ward of Object.values(district["xa-phuong"])) {
        const option = document.createElement("option");
        option.value = ward.name_with_type;
        option.textContent = ward.name_with_type;
        wardSelect.appendChild(option);
    }

    if (selectedWard) {
        wardSelect.value = selectedWard;
}
}







