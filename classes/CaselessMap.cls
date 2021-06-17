/**
 * Created by VeronikaAlkhimenok on 6/11/2021.
 */

public class CaselessMap {//
	@TestVisible private Map<String, SObject> innerMap;

	public CaselessMap() {
		this.innerMap = new Map<String, SObject>();
	}

	public CaselessMap(Map<String, SObject> mapToCopy) {
		Must.notBeNull(mapToCopy);
		Must.notContainNull(new List<String>(mapToCopy.keySet()));
		this.innerMap = new Map<String, SObject>();
		for (String key : mapToCopy.keySet()) {
			this.innerMap.put(key.toLowerCase(), mapToCopy.get(key));
		}
	}

	public CaselessMap(List<SObject> sobjectList) {
		Must.notBeNull(sobjectList);
		Must.notContainNull(sobjectList);
		this.innerMap = new Map<String, SObject>();
		for (SObject sobj : sobjectList) {
			Must.haveId(sobj);
			this.innerMap.put((String) sobj.Id, sobj);
		}
	}

	public void put(String key, SObject value) {
		Must.notBeNull(key);
		this.innerMap.put(key.toLowerCase(), value);
	}

	public SObject get(String key) {
		Must.notBeNull(key);
		return this.innerMap.get(key.toLowerCase());
	}

	public Integer size() {
		return this.innerMap.size();
	}
}